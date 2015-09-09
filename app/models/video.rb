class Video < ActiveRecord::Base
  belongs_to :stream

  mount_uploader :file, VideoUploader

  MAX_UPLOAD = 5

  def set_success(_format, _opts)
    self.success = true
  end
end
