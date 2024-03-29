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

  it 'is valid to have less than limitation number of videos' do
    Video::MAX_UPLOAD.times do
      stream.videos.create(file: fixture_file_upload('images/smile.png', 'image/png'))
    end
    expect(stream.valid?).to eq(true)
  end

  it 'is invalid to have more than limitation number of videos' do
    (Video::MAX_UPLOAD + 1).times do
      stream.videos.create(file: fixture_file_upload('images/smile.png', 'image/png'))
    end
    expect(stream.valid?).to eq(false)
    expect(stream.errors.full_messages.first).to include('videos can be uploaded')
  end
end
