class Channel < ActiveRecord::Base
  validates :title, presence: true
  validates :user_id, presence: true

  belongs_to :user
  has_many :streams

  enum components: [:live, :upcomming, :past]

  mount_uploader :icon, ImageUploader
  mount_uploader :banner, ImageUploader
end
