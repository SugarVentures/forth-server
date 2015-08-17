require 'rails_helper'

RSpec.describe Channel, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of :user_id }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:streams) }

  let(:channel) { create :channel }

  it 'acts as paranoid' do
    channel.delete
    expect(channel.deleted_at).not_to be_nil
    expect(Channel.only_deleted).to include(channel)
  end
end
