# == Schema Information
#
# Table name: notification_images
#
#  id          :integer          not null, primary key
#  facility_id :integer
#  title       :string
#  photo       :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class NotificationImage < ApplicationRecord
  belongs_to :facility
  mount_uploader :photo, AvatarUploader
  validates_presence_of :photo
end
