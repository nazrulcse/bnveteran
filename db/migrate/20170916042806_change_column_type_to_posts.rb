class ChangeColumnTypeToPosts < ActiveRecord::Migration[5.0]
  def change
    change_column :posts, :attachments, :text, default: nil, array: false
  end
end
