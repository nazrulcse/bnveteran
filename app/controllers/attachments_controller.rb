class AttachmentsController < ApplicationController
  before_action :set_post

  def create
    add_more_attachments(attachments_params[:attachments])
    flash[:error] = "Failed uploading attachments" unless @post.save
    redirect_to :back
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def add_more_attachments(new_attachments)
    attachments = @post.attachments # copy the old images
    attachments += new_attachments # concat old images with new ones
    @post.attachments = attachments # assign back
  end

  def attachments_params
    params.require(:post).permit({attachments: []}) # allow nested params as array
  end
end

