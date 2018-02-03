class PageBannersController < ApplicationController

  def index
    @page_banners = PageBanner.all
  end

  def show
    @page_banner = PageBanner.find_by(menu_bar_item_id: params[:id])

    p '##########################'
    p @page_banner
    p '##########################'

  end

end
