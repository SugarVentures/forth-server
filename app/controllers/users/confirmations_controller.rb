class Users::ConfirmationsController < Devise::ConfirmationsController
  private

  def after_confirmation_path_for(_name, user)
    sign_in(user)
    channel_path(current_user.channel)
  end
end
