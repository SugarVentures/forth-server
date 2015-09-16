class VideosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stream
  before_action :set_channel
  before_action :set_video, only: [:update, :destroy, :show]

  def create
    build_videos_into_stream
    if @stream.save
      redirect_to [@channel, @stream], notice: 'Videos were successfully uploaded.'
    else
      render :back
    end
  end

  def upload
    @videos = @stream.videos
  end

  def update
    if @video.update(video_params_file)
      redirect_to [@channel, @stream], notice: 'Videos were successfully changed.'
    else
      render :back
    end
  end

  def destroy
    @video.destroy
    redirect_to [@channel, @stream], notice: 'Video was successfully deleted.'
  end

  def show
  end

  private

  def build_videos_into_stream
    params[:video][:file].each do |file|
      @stream.videos.new(video_params.merge(file: file))
    end
  end

  def video_params
    params.require(:video).permit(:title, file: [])
  end

  def video_params_file
    params.require(:video).permit(:title, :file)
  end

  def set_channel
    @channel = Channel.find(params[:channel_id])
  end

  def set_stream
    @stream = Stream.find(params[:stream_id])
  end

  def set_video
    @video = Video.find(params[:id])
  end
end
