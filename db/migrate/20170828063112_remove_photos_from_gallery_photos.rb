class RemovePhotosFromGalleryPhotos < ActiveRecord::Migration[5.0]
  def change
    remove_column :gallery_photos, :photos, :string
  end
end
