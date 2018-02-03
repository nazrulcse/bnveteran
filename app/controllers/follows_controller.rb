class FollowsController < ApplicationController
  before_action :authenticate_user!
  respond_to :js

  def index
    respond_to do |format|
      @user = current_user
      if params[:follow].present?
        @follows = params[:follow] == 'followers' ? @user.user_followers : @user.following_users
      end
      format.js
      format.html
    end
  end

  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.stop_following(@user)
  end
end
