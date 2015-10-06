class Channel < ActiveRecord::Base
  validates :title, presence: true
  validates :user_id, presence: true

  belongs_to :user
  has_many :streams

  enum components: [:live, :upcomming, :past]

  mount_uploader :icon, ImageUploader
  mount_uploader :banner, ImageUploader

  acts_as_paranoid
  acts_as_followable

  after_initialize :set_default, if: :new_record?

  scope :search, -> (keyword) { where('LOWER(title) LIKE ? OR LOWER(description) LIKE ?', "%#{keyword.try(:downcase)}%", "%#{keyword.try(:downcase)}%") }
  scope :popular, -> { order('view_count DESC') }
  scope :features, -> { order('created_at DESC') }

  private

  def set_default
    self.title = user.name + ' channel' if user
  end
end
