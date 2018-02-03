class LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.find_by_id(params[:post_id])
    @likes = @post.likes.includes(:user)
  end

  def new
  end

  def create
    if params[:post_id].present?
      if Like.where("likable_id = ? AND current_user_id = ?", params[:post_id], current_user.id).present?
        Like.where("likable_id = ? AND current_user_id = ?", params[:post_id], current_user.id).first.delete
      else
        @like = Post.find(params[:post_id]).likes.create(current_user_id: current_user.id)

        post = Post.find_by(id:params[:post_id])
        post_creator = User.find_by(id: post.user_id)

       # @users.each do |user|
         # if following_user.followed_by?(user)
            @like.notifications.create(topic_id:post.id, user_id: post_creator.id, topic_creator_id: current_user.id, topic_creator_name: current_user.name)
         # end
      #  end
        @like
      end
    end
  end

end