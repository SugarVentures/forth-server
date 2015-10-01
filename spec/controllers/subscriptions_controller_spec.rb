require 'rails_helper'
include Devise::TestHelpers

RSpec.describe SubscriptionsController, type: :controller do
  let!(:user) { create :user }

  before do
    sign_in user
    user.follow(user.channel)
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index, user_id: user.id
      expect(assigns[:subscriptions]).to be_kind_of(Array)
      expect(assigns[:subscriptions].first).to eq(user.channel)
      expect(response).to have_http_status(:success)
    end
  end
end
