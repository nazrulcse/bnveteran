class NewsController < ApplicationController
before_action :set_news, only: [:show, :edit, :update, :destroy]

  def index
    @all_news = News.paginate(:page => params[:page], :per_page => 4).order(created_at: :desc)
  end

  def new
    @news = News.new
  end

  def create
    @news = News.new(news_params)
    if @news.save
      redirect_to root_path
    else
      render 'new', notice: @news.errors.full_messages.first
    end
  end

  def show
  end

  def edit
  end

  def update
  if @news.update_attributes(news_params)
    render 'show', notice: 'News updated successfully'
  else
    render 'edit', notice: 'Failed to update. please try again !'
  end

  end

  def destroy
    if @news.destroy
      redirect_to root_path, notice: 'News deleted successfully'
    else
      redirect_to root_path, notice: 'Failed to delete. please try again !'
    end
  end

  private
   def news_params
     params.require(:news).permit(:title, :description, :photo)
   end

  def set_news
    @news = News.friendly.find(params[:id])
  end

end
