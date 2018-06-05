class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy, :post_comment]

  def show
    respond_to do |format|
      @comments = @post.comments.all
      format.html
      format.js
    end
  end

  def create
    respond_to do |format|
      @post = current_user.posts.new(post_params)
      if params[:post][:shared_id].present?
        @post.is_share = true
        post_share = Post.find_by_id(params[:post][:shared_id])
        if post_share.is_share
          @post.shared_id = post_share.shared_id
        end
      end
      if @post.save
        if @post.is_share.present?
          @users = User.where.not(id: current_user.id, status: false)
          @users.each do |user|
            @post.notifications.create(topic_id:@post.id, user_id: user.id, topic_creator_id: current_user.id, topic_creator_name: current_user.name)
          end
        end

        @activity = PublicActivity::Activity.where(trackable_id: @post.id, trackable_type: 'Post')
        if params[:post_images_attributes].present?
          params[:post_images_attributes].each do |index, value|
            @post.post_images.create!(:image => value)
          end
        end
        format.js
        format.html {redirect_to root_path}
        format.json {render json: @activity}
      else
        format.js  notice: @post.errors.full_messages.first
        format.html {redirect_to root_path, notice: @post.errors.full_messages.first}
        format.json {render json: { error: 'Failed to process' }, status: 422}
      end
    end
    # @post = current_user.posts.new(post_params)
    # if @post.save
    #   redirect_to root_path
    # else
    #   redirect_to root_path, notice: @post.errors.full_messages.first
    # end
  end

  def share
    @post = Post.new
    @share_post = Post.friendly.find(params[:id])
    @share_post = @share_post.shared if @share_post.is_share
  end

  def who_shares
    user_ids = Post.where(is_share: true, shared_id: params[:id]).map(&:user_id)
    user_ids.uniq!
    @users = User.where(id: user_ids)
  end

  def view_activity
    @activity = PublicActivity::Activity.where(id: params[:activity_id])
  end

  def edit
    @user = current_user
    @hashtags = SimpleHashtag::Hashtag.all
    @post = Post.find(params[:id])
    @friends = @user.all_following.unshift(@user)

    # @activities = PublicActivity::Activity.where(owner_id: @friends).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    @un_friends = User.where.not(id: @friends.unshift(@user)).limit(5)
    respond_to do |format|
      format.js
      format.html
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        if params[:post_images_attributes].present?
          params[:post_images_attributes].each do |index, value|
            @post.post_images.create!(:image => value)
          end
        end

        if params[:deleted_images].present?
          image_ids = params[:deleted_images].split(',')
          image_ids.each do |image_id|
            post_image = PostImage.find_by_id(image_id)
            post_image.destroy if post_image.present?
          end
        end
        flash[:notice] = 'Updated successfully.'
        format.json { render json: {post_slug: @post.slug} }
        format.js
      else
        p @post.errors.inspect
        flash[:notice] = 'Failed to update. Please try again later.'
        format.json { render json: { error: 'Failed to process' }, status: 422 }
        format.js
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to root_path }
    end
  end

  def post_comment
    respond_to do |format|
      @comments = @post.comments.all
      format.js
    end
  end

  private
  def set_post
    @post = Post.friendly.find(params[:id])
    render_404 and return unless @post && User.find_by(id: @post.user_id)
  end

  def post_params
    params.require(:post).permit!
  end
end
