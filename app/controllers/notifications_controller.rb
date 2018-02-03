class NotificationsController < ApplicationController

  def index
    respond_to do |format|
      @notifications = Notification.where(user_id: current_user.id).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
      current_user.notifications.update_all(checked: true)
      format.html
      format.js
    end
  end

end
