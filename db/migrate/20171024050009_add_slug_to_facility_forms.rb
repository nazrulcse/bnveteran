class AddSlugToFacilityForms < ActiveRecord::Migration[5.0]
  def change
    add_column :facility_forms, :slug, :string
    add_index :facility_forms, :slug, unique: true
  end
end
