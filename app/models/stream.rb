class Stream < ActiveRecord::Base
  validates :title, presence: true
  validates :stream_key, presence: true, uniqueness: true
  validates :age_restriction, presence: true
  validates :channel_id, presence: true
  validates :user_id, presence: true
  # validates :start_end_validation
  validate :number_of_videos_is_valid?

  belongs_to :channel
  belongs_to :user
  has_many :videos

  enum view_mode: [:Private, :Group, :Public]

  mount_uploader :image, ImageUploader

  scope :search, -> (keyword) { where('LOWER(title) LIKE ? OR LOWER(description) LIKE ?', "%#{keyword.try(:downcase)}%", "%#{keyword.try(:downcase)}%") }
  scope :upcoming, -> { where('created_at.to_i' > Time.now.to_i) }
  scope :past, -> { where(Time.at(:created_at).to_i < Time.now.to_i) }

  acts_as_paranoid

  private

  def number_of_videos_is_valid?
    errors.add(:videos, 'Only ' + Video::MAX_UPLOAD.to_s + ' videos can be uploaded') if videos.count > Video::MAX_UPLOAD
  end
end
