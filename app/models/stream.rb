class Stream < ActiveRecord::Base
  validates :title, presence: true
  validates :stream_key, presence: true, uniqueness: true
  validates :age_restriction, presence: true
  validates :channel_id, presence: true
  validates :user_id, presence: true

  belongs_to :channel
  belongs_to :user

  enum view_mode: [:private_m, :group_m, :public_m]
end
