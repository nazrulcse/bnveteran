# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  room_id      :integer
#  user_id      :integer
#  content      :text
#  is_read      :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :integer
#

class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user


  def self.user_message(room, current_user)
    if room.messages.present?
      msg = room.messages.last
      msg
    end
  end

end
