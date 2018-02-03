class ChangeUploadFormFromFacilityAsUploadFacilityForm < ActiveRecord::Migration[5.0]
  def change
    rename_column :facilities, :upload_form, :upload_facility_form
  end
end
