class CreatePostImages < ActiveRecord::Migration[5.0]
  def change
    create_table :post_images do |t|
      t.references :post, foreign_key: true
      t.text :image
      t.string :caption

      t.timestamps
    end
  end
end
