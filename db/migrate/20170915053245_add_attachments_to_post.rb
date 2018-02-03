class AddAttachmentsToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :attachments, :string, array: true, default: [] # add attachments column as array
  end
end
