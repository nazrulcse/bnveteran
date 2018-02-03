class ChangeTitleFromFacilityAsOrganizationName < ActiveRecord::Migration[5.0]
  def change
    rename_column :facilities, :title, :organization_name
  end
end
