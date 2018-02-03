class AddSlugToAdminMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_messages, :slug, :string
    add_index :admin_messages, :slug, unique: true
  end
end
