class UserAuthorizedMail < Struct.new(:user)

  def perform
    p '***************Authorization mail sending started ******************'
    NotificationMailer.user_authorized(user).deliver_now
    p '******************End******************'
  end

end