class StreamSerializer < ActiveModel::Serializer
  attributes :id, :title, :game, :description, :videos

  def videos
    object.videos.map { |video| video.file.url }
  end
end
