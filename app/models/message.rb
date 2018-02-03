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
