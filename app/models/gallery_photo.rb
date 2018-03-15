# == Schema Information
#
# Table name: gallery_photos
#
#  id         :integer          not null, primary key
#  album_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image      :text
#

class GalleryPhoto < ApplicationRecord
  belongs_to :album
  mount_uploader :image, AvatarUploader
  validates_presence_of :image
end
