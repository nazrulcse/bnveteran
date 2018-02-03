class FixColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :likes, :cerrent_user_id, :current_user_id
  end
end
