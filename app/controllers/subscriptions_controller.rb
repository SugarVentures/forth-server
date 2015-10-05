class SubscriptionsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_channel, only: [:create, :destroy]
  before_action :set_user, only: :index

  def index
    @subscriptions = @user.all_following
  end

  def create
    current_user.follow(@channel)
    render json: { status: following_status }, status: 201
  end

  def destroy
    current_user.stop_following(@channel)
    render json: { status: following_status }, status: 200
  end

  private

  def set_channel
    @channel = Channel.find(params[:channel_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def following_status
    current_user.following?(@channel) ? 'following' : 'not_following'
  end
end
