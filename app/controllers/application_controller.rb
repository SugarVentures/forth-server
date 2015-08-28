class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from AppException::AuthenticationError, with: :authentication_error
  rescue_from AppException::InvalidFabricToken, with: :invalid_fabric_token
  rescue_from AppException::EmailUnconfirmed, with: :email_unconfirmed_error

  def authenticate_user_from_token!
    token = request.headers['HTTP_X_AUTH_TOKEN'].presence
    user = token && User.find_by(auth_token: token)
    fail AppException::AuthenticationError unless user
    sign_in user, store: false
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :name, :birthday) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :name, :birthday) }
  end

  private

  def error(msg, exception, status = 400)
    render json: { error_msg: msg, exception: exception.class.to_s },
           status: status
  end

  def authentication_error(exception)
    error('You\'re not authenticated/authorized. Please check that you have ' \
      'the correct auth_token and/or that you are trying to access a ' \
      'team that you have access to.', exception, 401)
  end

  def invalid_fabric_token(exception)
    error('The fabric tokens that you have provided is not valid. Please ' \
          'check that you have the correct token and/or that you are trying ' \
          'to access the correct endpoint.', exception, 401)
  end

  def email_unconfirmed_error(exception)
    error('A message with a confirmation link has been sent to your email ' \
          'address.  Please follow the link to activate your account.', exception, 409)
  end

  def format_json?
    request.format.json?
  end
end
