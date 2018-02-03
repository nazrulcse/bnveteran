class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable, only: :create
  respond_to :js

  def create
    @comment = @commentable.comments.new do |comment|
      comment.comment = params[:comment_text]
      comment.user = current_user
    end
    @comment.save!
    if @comment.save
      post = Post.find_by(id:params[:commentable_id])
      post_creator = User.find_by(id: post.user_id)
      @comment.notifications.create(topic_id:post.id, user_id: post_creator.id, topic_creator_id: current_user.id, topic_creator_name: current_user.name)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.commentable
    @comment_id = params[:id]
    @comment.destroy
  end

  private
  def find_commentable
    @commentable_type = params[:commentable_type].classify
    @commentable = @commentable_type.constantize.find(params[:commentable_id])
  end
end
