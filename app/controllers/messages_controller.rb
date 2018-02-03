class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    respond_to do |format|
      @rooms = current_user.rooms
      messages = Message.where( is_read: nil, recipient_id: current_user.id)
      messages.update_all(is_read: true)
      format.js
      format.html
    end
  end

  def new
    respond_to do |format|
      @users = User.where.not(id: current_user, status: false)
      format.js
    end
  end

  def show
    respond_to do |format|
      @user = User.find_by(id: params[:id])
      @room = Room.chat_room(@user, current_user)
      @messages = Message.where(room_id: @room.id).order(created_at: :asc)
      @message = Message.new
      @user = User.find_by(id: params[:id])
      format.js
    end
  end

  def live_search
    respond_to do |format|
      if params[:q].present?
        @users = User.search(params[:q]).where.not(id: current_user.id)
      else
        @users = User.where(status: true)
      end
      format.js
    end
  end

  def create
    respond_to do |format|
      @message = current_user.messages.build(message_params)

      if @message.save
        Delayed::Job.enqueue(ChatConversationMail.new(@message, current_user))
      end

      @message = Message.where(room_id: @message.room_id).last
      format.js
    end

  end

  private
  def message_params
    params.require(:message).permit(:content, :user_id, :room_id, :recipient_id)
  end

end
