class AddPhotosToGalleryPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :gallery_photos, :photos, :json
  end
end
