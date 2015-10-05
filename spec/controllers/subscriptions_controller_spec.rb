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

  describe 'POST #create' do
    it 'follows channel' do
      post :create, user_id: user.id, channel_id: user.channel
      expect(assigns[:channel]).to eq(user.channel)
      expect(response.body).to include('following')
      expect(response).to have_http_status(:success)
      expect(user.all_following).to include(user.channel)
    end
  end

  describe 'DELETE #destroy' do
    it 'unfollows channel' do
      user.follow(user.channel)
      delete :destroy, user_id: user.id, channel_id: user.channel
      expect(assigns[:channel]).to eq(user.channel)
      expect(response.body).to include('not_following')
      expect(response).to have_http_status(:success)
      expect(user.all_following).not_to include(user.channel)
    end
  end
end
