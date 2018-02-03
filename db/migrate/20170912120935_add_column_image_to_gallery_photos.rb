class AddColumnImageToGalleryPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :gallery_photos, :image, :text
  end
end
