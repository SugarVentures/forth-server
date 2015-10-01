class SubscriptionsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_channel, only: [:create, :destroy]
  before_action :set_user, only: :index

  def index
    @subscriptions = @user.all_following
  end

  def create
    current_user.follow(@channel)
  end

  def destroy
    current_user.stop_following(@channel)
  end

  private

  def set_channel
    @channel = Channel.find(params[:channel_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
