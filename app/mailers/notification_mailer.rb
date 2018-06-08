class NotificationMailer < ApplicationMailer

  def user_authorized(user)
    @user = user
    mail(to: user.email, subject: 'Authorized to Login BN Veterans')
  end

  def new_post(post, admin_user, user)
    @user = user
    @post = post
    @admin_user = admin_user
    mail(to: @admin_user.email, subject: "Bnveteran: A new post have been posted by #{@user.name}")
  end

end
