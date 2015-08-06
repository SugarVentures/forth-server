class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, presence: true, allow_blank: false, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :name, presence: true, allow_blank: false, uniqueness: true, length: { maximum: 50, too_long: '%{count} characters is the maximum allowed' }

  has_one :channel, dependent: :destroy

  def self.find_for_facebook_oauth(auth, _signed_in_resource = nil)
    data = AuthorizationService.check_facebook(auth.credentials.token)
    AuthorizationService.update_facebook(data)
  end

  def self.find_for_twitter_oauth(auth, _signed_in_resource = nil)
    data = AuthorizationService.check_twitter(auth.credentials.token, auth.credentials.secret)
    return false unless data
    params = {
      fabric_id: auth.uid,
      fabric_auth_token: auth.credentials.token,
      fabric_auth_token_secret: auth.credentials.secret
    }
    AuthorizationService.update_twitter(data, params)
  end
end
