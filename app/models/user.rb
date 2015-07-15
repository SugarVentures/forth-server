class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, presence: true, allow_blank: false, uniqueness: { scope: [:deleted_at] }, format: { with: VALID_EMAIL_REGEX }
  validates :name, presence: true, allow_blank: false, uniqueness: true, length: { maximum: 50, too_long: '%{count} characters is the maximum allowed' }
end
