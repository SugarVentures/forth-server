class ChannelsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_channel, only: [:show, :edit, :update, :destroy]

  def index
    @channels = Channel.all
  end

  def new
    @channel = Channel.new
  end

  def show
  end

  def create
    @channel = current_user.channels.create(channel_params)
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

  def channel_params
    params.require(:channel).permit(:title, :description)
  end
end
