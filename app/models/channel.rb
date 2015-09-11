class Channel < ActiveRecord::Base
  validates :title, presence: true
  validates :user_id, presence: true

  belongs_to :user
  has_many :streams

  enum components: [:live, :upcomming, :past]

  mount_uploader :icon, ImageUploader
  mount_uploader :banner, ImageUploader

  acts_as_paranoid

  scope :search, -> (keyword) { where('LOWER(title) LIKE ? OR LOWER(description) LIKE ?', "%#{keyword.try(:downcase)}%", "%#{keyword.try(:downcase)}%") }
  scope :popular, -> { order('created_at DESC').limit(10) }
  scope :features, -> { order('created_at DESC').limit(1) }
end
