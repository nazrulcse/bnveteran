class AddColumnFromAdminToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :from_admin, :boolean, default: false
  end
end
