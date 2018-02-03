module NewsHelper

  def latest_news
    News.limit(3).order(created_at: :desc)
  end

  # def latest_news_for_home
  #   News.limit(3).order(created_at: :desc)
  # end

end
