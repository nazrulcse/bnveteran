module FacilitiesHelper

  def facility_forms
    FacilityForm.order(:title)
  end

end
