require 'rails_helper'
include Devise::TestHelpers

RSpec.describe ChannelsController, type: :controller do
  let!(:user) { create :user }
  let(:channel) { create :channel, user: user }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'returns http success' do
      params = { channel: { title: 'abc', description: 'abc abc abc', components: 2 } }
      post :create, params
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET #edit' do
    it 'returns http success' do
      get :edit, id: channel.id
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #delete' do
    it 'returns http success' do
      delete :destroy, id: channel.id
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, id: channel.id
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH #update' do
    it 'returns http success' do
      params = { id: channel.id, channel: { title: 'abc', description: 'abc abc abc', components: 2 } }
      patch :update, params
      expect(response).to have_http_status(302)
    end
  end
end
