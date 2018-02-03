class AddColumnSharedIdToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :is_share, :boolean, default: false
    add_column :posts, :shared_id, :integer
    add_column :posts, :share_count, :integer, default: 0
  end
end
