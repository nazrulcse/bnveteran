# == Schema Information
#
# Table name: admin_messages
#
#  id         :integer          not null, primary key
#  subject    :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#

class AdminMessage < ApplicationRecord


  after_save :send_mail
  belongs_to :user

  extend FriendlyId
  friendly_id :subject, use: [:slugged, :finders]

  def send_mail
    admin_message = self
    Delayed::Job.enqueue(EmailSendJob.new(admin_message))
  end

end
