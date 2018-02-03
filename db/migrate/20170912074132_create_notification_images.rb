class CreateNotificationImages < ActiveRecord::Migration[5.0]
  def change
    create_table :notification_images do |t|
      t.references :facility, foreign_key: true
      t.string :title
      t.text :photo

      t.timestamps
    end
  end
end
