class NotificationImageNotificationJob < Struct.new(:notification_image)

  def perform
    p '***************admin notification after upload notification image ******************'
    User.active.each do |user|
      notification_image.notifications.create(topic_id: notification_image.id, user_id: user.id, from_admin: true)
    end
    p '******************End******************'
  end
end
