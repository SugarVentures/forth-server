require 'rails_helper'
include Devise::TestHelpers

RSpec.describe StreamsController, type: :controller do
  let!(:user) { create :user }
  let!(:channel) { create :channel, user: user }
  let!(:stream) { create :stream, user: user, channel: channel }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns http success for sign_in user' do
      get :index, channel_id: channel.id
      expect(assigns[:channel]).to eq(channel)
      expect(assigns[:streams]).to include(stream)
      expect(response).to have_http_status(:success)
    end

    it 'returns http success without sign_in' do
      sign_out user
      get :index, channel_id: channel.id
      expect(assigns[:channel]).to eq(channel)
      expect(assigns[:streams]).to include(stream)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new, channel_id: channel.id
      expect(assigns[:channel]).to eq(channel)
      expect(assigns[:stream]).to be_kind_of(Stream)
      expect(assigns[:stream].id).to be_nil
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns http success for sign_in user' do
      get :show, id: stream.id, channel_id: channel.id
      expect(assigns[:channel]).to eq(channel)
      expect(assigns[:stream]).to eq(stream)
      expect(response).to have_http_status(:success)
    end

    it 'returns http success without sign_in' do
      sign_out user
      get :show, id: stream.id, channel_id: channel.id
      expect(assigns[:channel]).to eq(channel)
      expect(assigns[:stream]).to eq(stream)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'returns 302' do
      params = { channel_id: channel.id, stream: { title: 'abc', game: 'game1' } }
      post :create, params
      expect(assigns[:channel]).to eq(channel)
      expect(assigns[:stream].title).to eq('abc')
      expect(assigns[:stream].stream_key.length).to eq(36)
      expect(Stream.find(assigns[:stream].id).game).to eq('game1')
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET #edit' do
    it 'returns http success' do
      get :edit, id: stream.id, channel_id: channel.id
      expect(assigns[:channel]).to eq(channel)
      expect(assigns[:stream]).to eq(stream)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH #update' do
    it 'returns http 302' do
      params = { id: stream.id, channel_id: channel.id, stream: { title: 'abc', game: 'game2' } }
      patch :update, params
      expect(assigns[:channel].id).to eq(channel.id)
      stream.reload
      expect(stream.title).to eq('abc')
      expect(stream.game).to eq('game2')
      expect(response).to have_http_status(302)
    end
  end

  describe 'POST #reset_key' do
    it 'returns http 302' do
      params = { stream_id: stream.id, channel_id: channel.id }
      key = stream.stream_key
      post :reset_key, params
      expect(assigns[:channel].id).to eq(channel.id)
      stream.reload
      expect(assigns[:stream]).to eq(stream)
      expect(stream.stream_key).not_to eq(key)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE #destroy' do
    it 'returns 302' do
      delete :destroy, id: stream.id, channel_id: channel.id
      expect(assigns[:channel].id).to eq(channel.id)
      stream.reload
      expect(assigns[:stream]).to eq(stream)
      expect(stream.deleted_at).not_to be_nil
      expect(response).to have_http_status(302)
    end
  end
end
