require 'rails_helper'

RSpec.describe Stream, type: :model do
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :stream_key }
  it { is_expected.to validate_uniqueness_of(:stream_key) }
  it { is_expected.to validate_presence_of :age_restriction }
  it { is_expected.to validate_presence_of :user_id }
  it { is_expected.to validate_presence_of :channel_id }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:channel) }

  let(:stream) { create :stream }

  it 'acts as paranoid' do
    stream.delete
    expect(stream.deleted_at).not_to be_nil
    expect(Stream.only_deleted).to include(stream)
  end
end
