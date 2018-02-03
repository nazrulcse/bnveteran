class AddNotificationIdToNotification < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :notification_id, :integer
  end
end
