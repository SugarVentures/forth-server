require 'rails_helper'
include Devise::TestHelpers

RSpec.describe ChannelsController, type: :controller do
  let!(:user) { create :user }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns http success for sign_in user' do
      get :index
      expect(assigns[:channels]).to be_kind_of(ActiveRecord::Relation)
      expect(response).to have_http_status(:success)
    end

    it 'returns http success without sign_in' do
      sign_out user
      get :index
      expect(assigns[:channels]).to be_kind_of(ActiveRecord::Relation)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns http success for sign_in user' do
      get :show, id: user.channel.id
      expect(assigns[:channel]).to eq(user.channel)
      expect(assigns[:popular_channels]).to be_kind_of(ActiveRecord::Relation)
      expect(response).to have_http_status(:success)
    end

    it 'returns http success without sign_in' do
      sign_out user
      get :show, id: user.channel.id
      expect(assigns[:channel]).to eq(user.channel)
      expect(assigns[:popular_channels]).to be_kind_of(ActiveRecord::Relation)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #edit' do
    it 'returns http success' do
      get :edit, id: user.channel.id
      expect(assigns[:channel]).to eq(user.channel)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH #update' do
    it 'returns http 302' do
      params = { id: user.channel.id, channel: { title: 'abc', description: 'abc abc abc', components: 2 } }
      patch :update, params
      expect(assigns[:channel].id).to eq(user.channel.id)
      expect(assigns[:channel].title).to eq('abc')
      expect(response).to have_http_status(302)
    end
  end

  describe 'DELETE #destroy' do
    it 'returns 302' do
      delete :destroy, id: user.channel.id
      expect(assigns[:channel].id).to eq(user.channel.id)
      expect(assigns[:channel].deleted_at).not_to be_nil
      expect(response).to have_http_status(302)
    end
  end
end
