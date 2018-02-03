class NotificationMailer < ApplicationMailer

  def user_authorized(user)
    @user = user
    mail(to: user.email, subject: 'Authorized to Login BN Veterans')
  end

end
