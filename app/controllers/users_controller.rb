class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @user = User.find(params[:id])
  end

  def update
    if current_user.update(user_params)
      current_user.set_min_age
      redirect_to root_path, notice: 'Successfully authenticated from Twitter account.'
    else
      render 'users/twitter'
    end
  end

  private

  def user_params
    params[:user].permit(:birthday)
  end
end
