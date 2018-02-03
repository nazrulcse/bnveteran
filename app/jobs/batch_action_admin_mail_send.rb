class BatchActionAdminMailSend < Struct.new(:user, :inputs, :ids)

  def perform
    p '***************admin batch mail sending started ******************'
      ContactMailer.contact_batch_email(inputs[:message], inputs[:subject], user.email).deliver_now
    p '******************End******************'
  end

end