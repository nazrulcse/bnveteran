class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :users, through: :user_rooms


  def self.chat_room(user, current_user)
    user_room_ids = user.room_ids
    if user_room_ids.present?
      current_user_rooms = current_user.user_rooms.where(room_id: user_room_ids )

      if current_user_rooms.present?
        current_user_rooms.first.room
      else
        room = Room.create(name:'private')
        user_room = UserRoom.create(user_id: user.id, room_id: room.id)
        current_user_room = UserRoom.create(user_id: current_user.id, room_id: room.id)
        return room
      end

    else
      room = Room.create(name:'private')
      user_room = UserRoom.create(user_id: user.id, room_id: room.id)
      current_user_room = UserRoom.create(user_id: current_user.id, room_id: room.id)
      return room
    end
  end


  def self.connected_user(room, current_user)
   user = room.users.where.not(id: current_user.id).first
   return user
  end

end
