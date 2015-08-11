class StreamsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_stream, only: [:show, :edit, :update, :destroy]
  before_action :set_channel

  def index
    @streams = @channel.streams.includes(:user)
  end

  def new
    @stream = Stream.new
  end

  def show
  end

  def create
    s_params = stream_params.merge(stream_key: SecureRandom.uuid)
    @stream = @channel.streams.new(s_params)
    if @stream.save
      redirect_to [@channel, @stream], notice: 'Stream was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @stream.update(stream_params)
      redirect_to [@channel, @stream], notice: 'Stream was successfully updated.'
    else
      render :edit
    end
  end

  def reset_key
    @stream = Stream.find(params[:stream_id])
    @stream.update(stream_key: SecureRandom.uuid)
    render :show
  end

  def destroy
    @stream.destroy
    redirect_to channel_streams_url, notice: 'Stream was successfully destroyed.'
  end

  private

  def set_channel
    @channel = Channel.find(params[:channel_id])
  end

  def set_stream
    @stream = Stream.find(params[:id])
  end

  def stream_params
    params.require(:stream).permit(:title, :game, :start, :end, :view_mode, :age_restriction, :group, :discussion, :description).merge(user: current_user).tap do |p|
      p[:view_mode] = p[:view_mode].to_i if p[:view_mode]
    end
  end
end
