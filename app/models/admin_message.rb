class AdminMessage < ApplicationRecord


  after_save :send_mail

  extend FriendlyId
  friendly_id :subject, use: [:slugged, :finders]

  def send_mail
    admin_message = self
    Delayed::Job.enqueue(EmailSendJob.new(admin_message))
  end

end
