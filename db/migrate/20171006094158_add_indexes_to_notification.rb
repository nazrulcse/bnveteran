class AddIndexesToNotification < ActiveRecord::Migration[5.0]
  def change
    add_index :notifications, [:notification_type, :notification_id]
  end
end
