require 'rails_helper'

RSpec.describe Stream, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:channel) }

  it { is_expected.to validate_uniqueness_of(:stream_key) }

  it { is_expected.to validate_presence_of :user_id }
  it { is_expected.to validate_presence_of :channel_id }
end
