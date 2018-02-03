class AddCurrentUserIdToLikes < ActiveRecord::Migration[5.0]
  def change
    add_column :likes, :cerrent_user_id, :integer
  end
end
