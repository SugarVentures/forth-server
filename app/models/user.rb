class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :omniauthable

  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, presence: true, allow_blank: false, uniqueness: true, format: { with: VALID_EMAIL_REGEX }, if: 'fabric_id.nil?'
  validates :name, presence: true, allow_blank: false, uniqueness: true, length: { maximum: 50 }
  validate :birthday_in_the_future?

  has_one :channel, dependent: :destroy
  has_many :streams
  acts_as_paranoid
  acts_as_follower

  before_save :ensure_authentication_token!
  after_save :set_default_channel

  scope :search, -> (keyword) { where('LOWER(name) LIKE ? OR LOWER(email) LIKE ?', "%#{keyword.try(:downcase)}%", "%#{keyword.try(:downcase)}%") }

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

  def set_min_age
    update(min_age: age)
  end

  private

  def ensure_authentication_token!
    self.auth_token = generate_authentication_token if auth_token.blank?
  end

  def set_default_channel
    create_channel if channel.nil? && name.present?
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.find_by(auth_token: token)
    end
  end

  def age
    d1 = birthday.strftime('%Y%m%d').to_i
    d2 = Time.zone.today.strftime('%Y%m%d').to_i
    (d2 - d1) / 10_000
  end

  def birthday_in_the_future?
    errors.add(:birthday, 'Birthday can not be in the future') if birthday.present? && birthday > Time.zone.now
  end
end
