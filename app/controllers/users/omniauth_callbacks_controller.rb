class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(request.env['omniauth.auth'], current_user)

    if @user.present? && @user.persisted?
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
      sign_in_redirect_to_channel
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url, alert: 'Your facebook account could not be signed in. Please sing up with your email.'
    end
  end

  def twitter
    @user = User.find_for_twitter_oauth(request.env['omniauth.auth'], current_user)

    if @user.present? && @user.persisted?
      return if birthday_form
      set_flash_message(:notice, :success, kind: 'Twitter') if is_navigational_format?
      sign_in_redirect_to_channel
    else
      session['devise.twitter_data'] = request.env['omniauth.auth'].except('extra')
      redirect_to new_user_registration_url, alert: 'Your twitter account could not be signed in. Please sing up with your email.'
    end
  end

  private

  def birthday_form
    return false if @user.min_age.present?

    sign_in @user
    render 'users/twitter'
  end

  def sign_in_redirect_to_channel
    sign_in @user, event: :authentication
    redirect_to channel_path(current_user.channel)
  end
end
