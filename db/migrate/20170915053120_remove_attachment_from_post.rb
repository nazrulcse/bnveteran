class RemoveAttachmentFromPost < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :attachment, :string
  end
end
