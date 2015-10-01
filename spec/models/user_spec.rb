require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to allow_value('abc@test.com').for(:email) }
  it { is_expected.not_to allow_value('abctest.com').for(:email) }

  it { is_expected.not_to allow_value(nil).for(:name) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(50) }

  it { is_expected.to have_one(:channel) }
  it { is_expected.to have_many(:streams) }

  it { is_expected.to have_db_column(:deleted_at) }
  it { is_expected.to have_db_index(:deleted_at) }

  let(:user) { create :user }

  it 'is not valid if birthday is in the future' do
    user.birthday = Faker::Date.forward(10_000)
    expect(user.valid?).to eq(false)
    expect(user.errors.full_messages.first).to include('Birthday can not be in the future')
  end

  it 'is valid if birthday is nil or past date' do
    user.birthday = nil
    expect(user.valid?).to eq(true)
    user.birthday = Faker::Date.backward(10_000)
    expect(user.valid?).to eq(true)
  end

  it 'acts as paranoid' do
    user.delete
    expect(user.deleted_at).not_to be_nil
    expect(User.only_deleted).to include(user)
  end

  it 'saves auth_token' do
    expect(user.auth_token).not_to be_nil
  end

  it 'saves min_age when set_min_age' do
    user.birthday = Faker::Date.backward(10_000)
    user.set_min_age
    expect(user.min_age).not_to be_nil
  end

  it 'is valid without email for twitter login user' do
    user.update(email: '', fabric_id: '12345')
    expect(user.valid?).to eq(true)
  end

  it 'is not valid without email for normal user' do
    user.update(email: '')
    expect(user.valid?).to eq(false)
  end
end
