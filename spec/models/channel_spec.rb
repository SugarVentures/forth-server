require 'rails_helper'

RSpec.describe Channel, type: :model do
  # it { is_expected.to validate_presence_of(:title) }
  # it { is_expected.to validate_presence_of :user_id }

  # it { is_expected.to belong_to(:user) }
  # it { is_expected.to have_many(:streams) }

  let(:user) { create :user }

  it 'acts as paranoid' do
    user.channel.delete
    expect(user.channel.deleted_at).not_to be_nil
    expect(Channel.only_deleted).to include(user.channel)
  end
end
