require 'rails_helper'

RSpec.describe Channel, type: :model do
  it { is_expected.to validate_presence_of(:title) }

  it 'should have valid factory' do
    FactoryGirl.build(:channel).should be_valid
  end

  it 'should require an email' do
    FactoryGirl.build(:channel, title: '').should_not be_valid
  end
end
