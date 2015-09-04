class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
  end

  def update
    if current_user.update(user_params)
      current_user.set_min_age
      set_flash_message(:notice, :success, kind: 'Twitter') if is_navigational_format?
      redirect_to root_path
    else
      render 'users/twitter'
    end
  end

  private

  def user_params
    params[:user].permit(:birthday)
  end
end
