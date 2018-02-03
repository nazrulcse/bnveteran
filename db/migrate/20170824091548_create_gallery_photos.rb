class CreateGalleryPhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :gallery_photos do |t|
      t.integer :album_id
      t.string :photo

      t.timestamps
    end
  end
end
