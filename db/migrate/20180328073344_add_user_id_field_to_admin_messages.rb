class AddUserIdFieldToAdminMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_messages, :user_id, :integer
  end
end
