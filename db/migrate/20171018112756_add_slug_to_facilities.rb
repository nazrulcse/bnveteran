class AddSlugToFacilities < ActiveRecord::Migration[5.0]
  def change
    add_column :facilities, :slug, :string
    add_index :facilities, :slug, unique: true
  end
end
