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
  has_many :notifications, as: :notification, dependent: :destroy

  mount_uploader :photo, AvatarUploader
  validates_presence_of :photo

  after_create :notify_user

  private

  def notify_user
    Delayed::Job.enqueue(NotificationImageNotificationJob.new(self))
  end
end
