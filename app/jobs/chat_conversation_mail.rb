class ChatConversationMail < Struct.new(:message, :current_user)

  def perform
    p '***************Conversation mail sending started ******************'
    room_id = message.room_id
    user_rooms = UserRoom.where(room_id: room_id)
    user_rooms.each do |chat_room|
      unless chat_room.user_id == current_user.id
        recipient_user = User.find_by(id: chat_room.user_id)
        ContactMailer.chatting_mail(recipient_user, current_user).deliver
      end
    end
    p '******************End******************'
  end

end