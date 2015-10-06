require 'rails_helper'
include Devise::TestHelpers

RSpec.describe StreamsController, type: :controller do
  let!(:user) { create :user }
  let!(:stream) { create :stream, user: user, channel: user.channel, temp: false }
  let!(:stream2) { create :stream, user: user, channel: user.channel, temp: false }
  let!(:stream3) { create :stream, user: user, channel: user.channel, temp: false }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns http success for sign_in user' do
      get :index, channel_id: user.channel.id
      expect(assigns[:channel]).to eq(user.channel)
      expect(assigns[:streams]).to include(stream)
      expect(response).to have_http_status(:success)
    end

    it 'returns http success without sign_in' do
      sign_out user
      get :index, channel_id: user.channel.id
      expect(assigns[:channel]).to eq(user.channel)
      expect(assigns[:streams]).to include(stream)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new, channel_id: user.channel.id
      expect(assigns[:channel]).to eq(user.channel)
      expect(assigns[:stream]).to be_kind_of(Stream)
      expect(assigns[:stream].id).not_to be_nil
      expect(assigns[:stream].temp).to eq(true)
      expect(assigns[:stream].stream_key).not_to be_nil
      expect(response).to have_http_status(:success)
    end

    it 'returns http success when user has temp stream' do
      stream2.update(temp: true)
      get :new, channel_id: user.channel.id
      expect(assigns[:channel]).to eq(user.channel)
      expect(assigns[:stream]).to eq(stream2)
      expect(assigns[:stream].stream_key).not_to be_nil
      expect(response).to have_http_status(:success)
    end

    it 'returns http success when user has some temp streams' do
      stream2.update(temp: true)
      stream3.update(temp: true)
      get :new, channel_id: user.channel.id
      expect(assigns[:channel]).to eq(user.channel)
      expect(assigns[:stream]).to be_kind_of(Stream)
      expect(assigns[:stream].id).not_to be_nil
      expect(assigns[:stream].id).not_to eq(stream2.id)
      expect(assigns[:stream].id).not_to eq(stream3.id)
      expect(assigns[:stream].temp).to eq(true)
      expect(assigns[:stream].stream_key).not_to be_nil
      expect(Stream.where(id: [stream2.id, stream3.id]).count).to eq(0)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns http success for sign_in user' do
      get :show, id: stream.id, channel_id: user.channel.id
      expect(assigns[:channel]).to eq(user.channel)
      expect(assigns[:stream]).to eq(stream)
      expect(response).to have_http_status(:success)
    end

    it 'returns http success without sign_in' do
      sign_out user
      get :show, id: stream.id, channel_id: user.channel.id
      expect(assigns[:channel]).to eq(user.channel)
      expect(assigns[:stream]).to eq(stream)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #edit' do
    it 'returns http success' do
      get :edit, id: stream.id, channel_id: user.channel.id
      expect(assigns[:channel]).to eq(user.channel)
      expect(assigns[:stream]).to eq(stream)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH #update' do
    it 'returns http 302' do
      params = { id: stream.id, channel_id: user.channel.id, stream: { title: 'abc', game: :Action } }
      patch :update, params
      expect(assigns[:channel].id).to eq(user.channel.id)
      stream.reload
      expect(stream.title).to eq('abc')
      expect(stream.game).to eq('Action')
      expect(response).to have_http_status(302)
    end
  end

  describe 'POST #reset_key' do
    it 'returns http 302' do
      params = { id: stream.id, channel_id: user.channel.id }
      key = stream.stream_key
      post :reset_key, params
      expect(assigns[:channel].id).to eq(user.channel.id)
      stream.reload
      expect(assigns[:stream]).to eq(stream)
      expect(stream.stream_key).not_to eq(key)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE #destroy' do
    it 'returns 302' do
      delete :destroy, id: stream.id, channel_id: user.channel.id
      expect(assigns[:channel].id).to eq(user.channel.id)
      stream.reload
      expect(assigns[:stream]).to eq(stream)
      expect(stream.deleted_at).not_to be_nil
      expect(response).to have_http_status(302)
    end
  end
end
