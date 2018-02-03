class ContactMailer < ApplicationMailer

  def contact_mail(contact)
    @contact_info = contact
    mail(to: 'bnveteran.noreply@gmail.com', subject: 'Message From BN veteran', from: contact.email)
  end

  def chatting_mail(recipient, current_user)
    @recipient = recipient
    @message_sender = current_user
    mail(to: recipient.email, subject: 'You have got a new message in BN Veteran', from: 'bnveteran.noreply@gmail.com')
  end

  def contact_batch_email(message, subject, recipient)
    @message_admin = message
    @admin_message_subject = subject
    @recipient = recipient
    mail(to: recipient, subject: 'You have got a new message from the admin of BN Veteran', from: 'bnveteran.noreply@gmail.com')
  end

  def send_admin_message(admin_message, user)
    @admin_message = admin_message
    @user = user
    mail(to: user.email, subject: 'You have got a new message from the admin of BN Veteran', from: 'bnveteran.noreply@gmail.com')
  end

end
