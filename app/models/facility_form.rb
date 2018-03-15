# == Schema Information
#
# Table name: facility_forms
#
#  id          :integer          not null, primary key
#  facility_id :integer
#  title       :string
#  form        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#

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
