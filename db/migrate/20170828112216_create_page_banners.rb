class CreatePageBanners < ActiveRecord::Migration[5.0]
  def change
    create_table :page_banners do |t|
      t.string :banner_photo
      t.integer :menu_bar_item_id

      t.timestamps
    end
  end
end
