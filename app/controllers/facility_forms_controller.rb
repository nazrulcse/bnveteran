class FacilityFormsController < ApplicationController
  before_action :set_facility_form, only: [:download]


  def index
    @facility_forms = FacilityForm.order(:title).paginate(page: params[:page], per_page: 9)
  end

  def download
    send_file @facility_form.form.path

  end

  private

  def set_facility_form
    @facility_form = FacilityForm.friendly.find(params[:id])
  end
end
