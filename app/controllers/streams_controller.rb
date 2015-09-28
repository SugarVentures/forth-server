class StreamsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :check]
  before_action :set_stream, except: [:index, :new, :create, :check]
  before_action :set_channel, except: :check
  before_action :authenticate_user_from_token!, if: :format_json?

  def index
    @streams = @channel.streams.includes(:user)
    @streams = streams_scope
  end

  def new
    @stream = Stream.new
  end

  def show
  end

  def create
    @stream = new_stream
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
    @stream.update(stream_key: SecureRandom.uuid)
    render :show
  end

  def destroy
    @stream.destroy
    redirect_to channel_streams_url, notice: 'Stream was successfully destroyed.'
  end

  def check
    stream = current_user.streams.find_by(stream_key: params[:stream_key])
    if current_user.streams.find_by(stream_key: params[:stream_key])
      render json: stream, serializer: StreamSerializer, status: 200
    else
      render json: {}, status: 403
    end
  end

  private

  def streams_scope
    case params[:scope]
    when 'upcoming'
      @streams.upcoming
    when 'past'
      @streams.past
    else
      @streams
    end
  end

  def set_channel
    @channel = Channel.find(params[:channel_id])
  end

  def set_stream
    @stream = Stream.find(params[:id])
  end

  def new_stream
    s_params = stream_params.merge(stream_key: SecureRandom.uuid)
    @channel.streams.new(s_params)
  end

  def stream_params
    params.require(:stream).permit(:title, :game, :start, :end, :view_mode, :age_restriction, :group, :discussion, :description, :image).merge(user: current_user).tap do |p|
      p[:view_mode] = p[:view_mode].to_i if p[:view_mode]
    end
  end
end
