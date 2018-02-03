module MessagesHelper

  def user_last_chat(user)
    Message.where(user_id: user.id).last
  end

end
