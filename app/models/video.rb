class Video < ActiveRecord::Base
  mount_uploader :file, VideoFileUploader
end
