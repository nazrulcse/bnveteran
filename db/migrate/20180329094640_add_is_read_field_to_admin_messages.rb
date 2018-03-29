class AddIsReadFieldToAdminMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_messages, :is_read, :boolean, default: false
  end
end
