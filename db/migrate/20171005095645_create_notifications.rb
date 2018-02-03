class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :topic_id
      t.integer :user_id
      t.boolean :checked

      t.timestamps
    end
  end
end
