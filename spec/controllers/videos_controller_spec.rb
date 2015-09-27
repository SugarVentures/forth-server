require 'rails_helper'
include Devise::TestHelpers

RSpec.describe VideosController, type: :controller do
  let!(:user) { create :user }
  let!(:stream) { create :stream, user: user, channel: user.channel }

  before do
    sign_in user
  end

  describe 'POST #create' do
    it 'returns http 302 when create video' do
      params = { channel_id: user.channel.id, stream_id: stream.id, video: { file: [fixture_file_upload('videos/video.webm', 'movie/webm')] } }
      post :create, params
      expect(assigns[:channel]).to eq(user.channel)
      expect(assigns[:stream]).to eq(stream)
      expect(assigns[:stream].videos.count).to eq(1)
      expect(response).to have_http_status(302)
    end

    it 'redirect to upload page when fail to create video' do
      params = { channel_id: user.channel.id, stream_id: stream.id, video: { file: ['abc'] } }
      post :create, params
      expect(assigns[:channel]).to eq(user.channel)
      expect(assigns[:stream]).to eq(stream)
      is_expected.to redirect_to("/channels/#{user.channel.id}/streams/#{stream.id}/videos/upload")
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET #upload' do
    it 'returns http 302 when create video' do
      stream.videos.create(file: fixture_file_upload('videos/video.webm', 'movie/webm'))

      params = { channel_id: user.channel.id, stream_id: stream.id }
      get :upload, params
      expect(assigns[:channel]).to eq(user.channel)
      expect(assigns[:stream]).to eq(stream)
      expect(assigns[:videos].first).to be_kind_of(Video)
      expect(response).to have_http_status(:success)
    end
  end
end
