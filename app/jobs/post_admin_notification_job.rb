class PostAdminNotificationJob < Struct.new(:post, :user)

  def perform
    p '***************admin notification after new post ******************'
    AdminUser.all.each do |admin_user|
      NotificationMailer.new_post(post, admin_user, user).deliver_now
    end
    p '******************End******************'
  end

end
