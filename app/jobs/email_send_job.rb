class EmailSendJob < Struct.new(:admin_message)

  def perform
    p '****************Started Sending admin message*****************'
    users = User.where(status:true)
    users.each do |user|
      ContactMailer.send_admin_message(admin_message, user).deliver_now
    end
    p '******************End******************'
  end

end