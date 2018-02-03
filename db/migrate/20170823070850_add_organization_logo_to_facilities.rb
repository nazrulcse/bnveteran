class AddOrganizationLogoToFacilities < ActiveRecord::Migration[5.0]
  def change
    add_column :facilities, :organization_logo, :string
  end
end
