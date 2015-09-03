class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
  end

  def update
    current_user.update(user_params)
    current_user.set_min_age
    redirect_to root_path
  end

  private

  def user_params
    params[:user].permit(:birthday)
  end
end
