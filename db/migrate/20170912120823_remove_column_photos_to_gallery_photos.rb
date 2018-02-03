class RemoveColumnPhotosToGalleryPhotos < ActiveRecord::Migration[5.0]
  def change
    remove_column :gallery_photos, :photos
  end
end
