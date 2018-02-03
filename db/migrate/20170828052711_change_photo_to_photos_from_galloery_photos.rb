class ChangePhotoToPhotosFromGalloeryPhotos < ActiveRecord::Migration[5.0]
  def change
    rename_column :gallery_photos, :photo, :photos
  end
end
