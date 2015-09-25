require 'rails_helper'

RSpec.describe StreamsController, type: :api do
  let(:user) { create :user }
  let!(:channel) { create :channel, user: user }
  let!(:stream) { create :stream, user: user, channel: channel, stream_key: 'Key_is_ABC123', description: 'Game' }

  describe 'CHECK - stream_key' do
    it 'return 200 when receive correct key' do
      stream.videos.create(file: fixture_file_upload('images/smile.png', 'image/png'))
      get '/api/stream_key', { stream_key: 'Key_is_ABC123' }, auth(user)
      response_stream = JSON.parse(last_response.body)['stream']
      expect(last_response.status).to eq(200)
      expect(response_stream['description']).to eq('Game')
      expect(response_stream['videos'].first).to include('/smile.png')
    end

    it 'return 403 when receive wrong key' do
      get '/api/stream_key', { stream_key: 'wrong_Key_123' }, auth(user)
      expect(last_response.status).to eq(403)
    end

    it 'retuen 401 when receive wrong user auth_token' do
      get '/api/stream_key', stream_key: 'Key_is_ABC123'
      expect(last_response.status).to eq(401)
    end
  end
end
