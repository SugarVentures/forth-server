class Video < ActiveRecord::Base
  validates :file, presence: true

  belongs_to :stream

  mount_uploader :file, VideoUploader
  mount_uploader :thumb, ImageUploader

  MAX_UPLOAD = 5

  def set_success(_format, _opts)
    self.success = true
  end
end
