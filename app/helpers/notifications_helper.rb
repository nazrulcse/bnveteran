module NotificationsHelper

  def notifications
    Notification.where(user_id: current_user.id, checked: nil)
  end

  def unread_messages
    msg_count = Message.where(is_read: nil, recipient_id: current_user.id).count || 0
    admin_msg_count = current_user.admin_messages.where(is_read: false).count || 0
    msg_count + admin_msg_count
  end

end
