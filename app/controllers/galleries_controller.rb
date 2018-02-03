class GalleriesController < ApplicationController

  def index
    @gallery_photos = GalleryPhoto.paginate(:page => params[:page], :per_page => 9).order(created_at: :desc)
  end

  def album_wise_photos
    @album = Album.friendly.find(params[:id])
    @gallery_album_photos = GalleryPhoto.where(album_id: @album.id).paginate(:page => params[:page], :per_page => 9)
  end

end
