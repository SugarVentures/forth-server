class ChannelsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_channel, only: [:show, :edit, :update, :destroy]

  def index
    @channels = Channel.all.includes(:user)
  end

  def new
    return if check_channel_presence?
    @channel = Channel.new
  end

  def show
    @popular_channels = Channel.all
  end

  def create
    return if check_channel_presence?
    @channel = current_user.build_channel(channel_params)
    if @channel.save
      redirect_to @channel, notice: 'Channel was successfully created.'
    else
      render :new
    end
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
