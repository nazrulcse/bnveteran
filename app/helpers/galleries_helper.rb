module GalleriesHelper


  def default_gallery_photos_for_home
    GalleryPhoto.order(created_at: :desc).limit(4)
  end

  def default_gallery_photos
    GalleryPhoto.order(created_at: :desc).limit(8)
  end

  def photo_albums
    Album.all
  end

end
