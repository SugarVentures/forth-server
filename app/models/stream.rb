class Stream < ActiveRecord::Base
  validates :title, presence: true
  validates :stream_key, presence: true, uniqueness: true
  validates :age_restriction, presence: true
  validates :channel_id, presence: true
  validates :user_id, presence: true
  # validates :start_end_validation

  belongs_to :channel
  belongs_to :user

  enum view_mode: [:Private, :Group, :Public]
end
