class StreamsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :check]
  before_action :set_stream, except: [:index, :new, :check]
  before_action :set_channel, except: :check
  before_action :authenticate_user_from_token!, if: :format_json?
  before_action :increment_counter, only: :show

  def index
    @streams = @channel.streams.where(temp: false).includes(:user)
    @streams = streams_scope
  end

  def new
    delete_temps if @channel.streams.where(temp: true).count > 1
    @stream = @channel.streams.find_by(temp: true)
    @stream = @channel.streams.create(new_stream) if @stream.nil?
  end

  def show
    redirect_to channel_streams_url, notice: 'Stream is not existing' if @stream.temp == true
  end

  def edit
  end

  def update
    if @stream.update stream_params.merge(temp: false)
      redirect_to [@channel, @stream], notice: 'Stream was successfully created.'
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

  def delete_temps
    s_ids = @channel.streams.where(temp: true).pluck(:id)
    Stream.where(id: s_ids).delete_all
    Stream.only_deleted.where(id: s_ids).delete_all
  end

  def new_stream
    { title: current_user.name + ' stream', user: current_user, stream_key: SecureRandom.uuid, temp: true }
  end

  def stream_params
    params.require(:stream).permit(:title, :game, :start, :end, :stream_key, :view_mode, :age_restriction, :group, :discussion, :description, :image).merge(user: current_user).tap do |p|
      p[:view_mode] = p[:view_mode].to_i if p[:view_mode]
    end
  end

  def increment_counter
    return if current_user == @stream.user
    Stream.increment_counter(:view_count, @stream.id)
    Channel.increment_counter(:view_count, @channel.id)
  end
end
