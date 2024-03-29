class ChannelsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_channel, only: [:show, :edit, :update, :destroy]

  def index
    @channels = Channel.all.includes(:user)
    @channels = channels_scope
  end

  def show
    @popular_channels = Channel.all
  end

  def edit
  end

  def update
    if @channel.update(channel_params)
      redirect_to @channel, notice: 'Channel was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @channel.destroy
    redirect_to channels_url, notice: 'Channel was successfully destroyed.'
  end

  private

  def set_channel
    @channel = Channel.find(params[:id])
  end

  def channels_scope
    case params[:scope]
    when 'popular'
      @channels.popular
    when 'features'
      @channels.features
    else
      @channels.popular
    end
  end

  def check_channel_presence?
    return false unless current_user.channel.present?
    redirect_to channels_url, notice: 'Channel has already been created.'
    true
  end

  def channel_params
    params.require(:channel).permit(:title, :description, :icon, :banner, :components).tap do |p|
      p[:components] = p[:components].to_i if p[:components]
    end
  end
end
