require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_uniqueness_of(:email) }

  it 'should have valid factory' do
    FactoryGirl.build(:user).should be_valid
  end

  it 'should require an email' do
    FactoryGirl.build(:user, email: '').should_not be_valid
  end
end
