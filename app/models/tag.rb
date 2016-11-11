class Tag < ActiveRecord::Base
  belongs_to :category
  mount_uploader :banner, TagUploader
  mount_uploader :image, TagUploader
end
