require 'rails_helper'

RSpec.describe SessionsController, type: :api do
  describe 'CREATE - login' do
    let!(:user) do
      create :user,
             email: 'test@test.com',
             password: '12345678',
             password_confirmation: '12345678'
    end

    it 'should login with successful email and password' do
      user_params = {
        email: 'test@test.com',
        password: '12345678'
      }
      post '/api/sessions', user_params

      response = JSON.parse last_response.body
      expect(response['user']['id']).to eq user.id
      expect(response['user']['auth_token']).to eq user.auth_token
      expect(last_response.status).to eq(200)
    end

    it 'should return 401 with invalid email or password' do
      user_params = {
        email: 'test@test.com',
        password: '111111111'
      }
      post '/api/sessions', user_params
      expect(last_response.status).to eq(401)
    end

    it 'should return 401 with unconfiemed email' do
      user_params = {
        email: 'test@test.com',
        password: '12345678'
      }
      user.update(confirmed_at: nil)
      post '/api/sessions', user_params
      expect(last_response.status).to eq(409)
    end

    it 'should login with facebook token for existing user with email' do
      user_params = {
        fb_token: 'test_test_token'
      }
      data = {
        email: 'test@test.com',
        fb_id: '123123123'
      }
      expect(AuthorizationService).to receive(:check_facebook).with('test_test_token').and_return(data)
      post 'api/sessions/facebook', user_params

      response = JSON.parse last_response.body
      expect(User.find(user.id).fb_id).to eq('123123123')
      expect(response['user']['id']).to eq user.id
      expect(response['user']['auth_token']).to eq user.auth_token
      expect(last_response.status).to eq(200)
    end

    let!(:user_fb) do
      create :user,
             fb_id: '12345'
    end

    it 'should login with facebook token for existing user without email' do
      user_params = {
        fb_token: 'test_test_token'
      }
      User.delete_all(email: 'un_registered@test.com')
      data = {
        email: 'un_registered@test.com',
        fb_id: '12345'
      }
      expect(AuthorizationService).to receive(:check_facebook).with('test_test_token').and_return(data)
      post 'api/sessions/facebook', user_params
      response = JSON.parse last_response.body
      expect(response['user']['id']).to eq user_fb.id
      expect(response['user']['auth_token']).to eq user_fb.auth_token
      expect(last_response.status).to eq(200)
    end

    it 'return 401 when login with invalid facebook acount' do
      user_params = {
        fb_token: 'test_test_token'
      }
      User.delete_all(email: 'un_registered@test.com')
      user_count = User.count
      data = {
        email: 'un_registered@test.com',
        fb_id: '111222333'
      }
      expect(AuthorizationService).to receive(:check_facebook).with('test_test_token').and_return(data)
      post 'api/sessions/facebook', user_params
      expect(User.count).to eq(user_count)
      expect(last_response.status).to eq(401)
    end

    let!(:user_twitter) do
      create :user,
             fabric_id: '123123',
             fabric_auth_token: 'auth_token_for_twitter',
             fabric_auth_token_secret: 'auth_token_secret_for_twitter',
             auth_token: 'abc123ABC'
    end

    it 'login with twitter account' do
      user_params = {
        fabric_id: '123123',
        fabric_auth_token: 'auth_token_for_twitter',
        fabric_auth_token_secret: 'auth_token_secret_for_twitter'
      }
      data = { screen_name: 'My name' }
      expect(AuthorizationService).to receive(:check_twitter).with('auth_token_for_twitter', 'auth_token_secret_for_twitter').and_return(data).once
      post 'api/sessions/twitter', user_params
      response = JSON.parse last_response.body
      expect(response['user']['id']).to eq user_twitter.id
      expect(response['user']['auth_token']).to eq user_twitter.auth_token
      expect(last_response.status).to eq(200)
    end

    it 'return 401 when login with invalid twitter account' do
      user_params = {
        fabric_id: '111111',
        fabric_auth_token: 'wrong_auth_token_for_twitter',
        fabric_auth_token_secret: 'wrong_auth_token_secret_for_twitter'
      }
      post 'api/sessions/twitter', user_params
      expect(last_response.status).to eq(401)
    end
  end
end
