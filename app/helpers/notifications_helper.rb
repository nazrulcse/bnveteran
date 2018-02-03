module NotificationsHelper

  def notifications
   Notification.where(user_id: current_user.id ,checked: nil)
  end

  def unread_messages
    Message.where(is_read: nil, recipient_id: current_user.id)
  end

end
