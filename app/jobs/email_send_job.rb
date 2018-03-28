class EmailSendJob < Struct.new(:admin_message)

  def perform
    p '****************Started Sending admin message*****************'
    if admin_message.user_id.present?
      user =  User.find_by_id(admin_message.user_id)
      ContactMailer.send_admin_message(admin_message, user).deliver_now
    else
      users = User.where(status:true)
      users.each do |user|
        ContactMailer.send_admin_message(admin_message, user).deliver_now
      end
    end
    p '******************End******************'
  end

end