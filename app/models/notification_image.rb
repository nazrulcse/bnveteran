class NotificationImage < ApplicationRecord
  belongs_to :facility
  mount_uploader :photo, AvatarUploader
  validates_presence_of :photo
end
