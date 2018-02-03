class HashtagsController < ApplicationController
  before_action :authenticate_user!

  def show
    respond_to do |format|
      @user = current_user
      @hashtag = SimpleHashtag::Hashtag.find_by_name(params[:hashtag])
      @hashtagged = @hashtag.hashtaggables if @hashtag
      post_ids = @hashtagged.map(&:id)
      @activities = PublicActivity::Activity.where(trackable_id: post_ids, trackable_type: 'Post').order(created_at: :desc).paginate(page: params[:page], per_page: 10)

    format.js
    format.html
    end
  end

end
