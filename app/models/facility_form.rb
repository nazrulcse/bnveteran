class FacilityForm < ApplicationRecord
  belongs_to :facility
  mount_uploader :form, AvatarUploader
  validates_presence_of :title, :form

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  def is_doc?
    form.path.downcase.end_with?('.doc') || form.path.downcase.end_with?('.docx')
  end

end
