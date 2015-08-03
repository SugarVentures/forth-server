class Users::ConfirmationsController < Devise::ConfirmationsController
  private

  def after_confirmation_path_for(_name, user)
    sign_in(user)
    root_path
  end
end
