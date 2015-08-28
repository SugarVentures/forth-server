class SessionsController < ApplicationController
  skip_authorization_check

  def facebook
    data = AuthorizationService.check_facebook(params[:fb_token])
    user = User.where('email = ? OR fb_id = ?', data[:email], data[:fb_id]).first
    fail AppException::AuthenticationError unless user
    user = AuthorizationService.update_facebook(data)
    render json: user, serializer: SessionSerializer, root: 'user', status: 200
  end

  def twitter
    user = User.find_by(fabric_id: params[:fabric_id])
    fail AppException::AuthenticationError unless user
    data = AuthorizationService.check_twitter(params[:fabric_auth_token], params[:fabric_auth_token_secret])
    fail AppException::InvalidFabricToken unless data
    user = AuthorizationService.update_twitter(data, params)
    render json: user, serializer: SessionSerializer, root: 'user', status: 200
  end

  def create
    user = User.find_by(email: params[:email]) if params[:email].present?
    unless user && user.valid_password?(params[:password])
      fail AppException::AuthenticationError
    end
    fail AppException::EmailUnconfirmed unless user.confirmed?
    render json: user, serializer: SessionSerializer, root: 'user', status: 200
  end
end
