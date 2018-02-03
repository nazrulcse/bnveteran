class GalleryPhoto < ApplicationRecord
  belongs_to :album
  mount_uploader :image, AvatarUploader
  validates_presence_of :image
end
