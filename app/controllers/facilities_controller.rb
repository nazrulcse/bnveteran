class FacilitiesController < ApplicationController
 before_action :set_facility, only: [:show]
  def index
  @facilities = Facility.order(created_at: :asc)
  @meta_title = meta_title 'BN Veteran Facilities'
  @meta_description = 'BN Veteran is a social site for Bangladesh Navy veterans to communicate each other among them.'
  end

  def show
   @meta_title = meta_title @facility.organization_name
   @canonical_url = @facility.slug.present? ? facility_path(@facility.slug) : facility_path(@facility.id)
   @og_properties = {
       title: @meta_title,
       type:  'website',
       image: view_context.image_url('/app/assets/images/bnveteran.png'),  # this file should exist in /app/assets/images/logo.png
       url: @canonical_url
   }
  end



  private

  def set_facility
    @facility = Facility.friendly.find(params[:id])
  end

end
