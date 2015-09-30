class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel, except: :index

  def index
    @subscriptions = current_user.all_following
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
end
