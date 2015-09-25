class Stream < ActiveRecord::Base
  validates :title, presence: true
  validates :stream_key, presence: true, uniqueness: true
  validates :age_restriction, presence: true
  validates :channel_id, presence: true
  validates :user_id, presence: true
  # validates :start_end_validation
  validate :videos_are_less_than_5?

  belongs_to :channel
  belongs_to :user
  has_many :videos

  enum view_mode: [:Private, :Group, :Public]

  scope :search, -> (keyword) { where('LOWER(title) LIKE ? OR LOWER(description) LIKE ?', "%#{keyword.try(:downcase)}%", "%#{keyword.try(:downcase)}%") }
  scope :upcoming, -> { where('created_at.to_i' > Time.now.to_i) }
  scope :past, -> { where(Time.at(:created_at).to_i < Time.now.to_i) }

  acts_as_paranoid

  private

  def videos_are_less_than_5?
    errors.add(:videos, 'Only 5 videos can be uploaded') if videos.count > Video::MAX_UPLOAD
  end
end
