class Facility < ApplicationRecord

  has_many :facility_forms, dependent: :destroy
  has_many :notification_images, dependent: :destroy

  validates_presence_of :organization_name

  mount_uploader :upload_facility_form, AvatarUploader
  mount_uploader :organization_logo, AvatarUploader

  accepts_nested_attributes_for :facility_forms, :allow_destroy => true
  accepts_nested_attributes_for :notification_images, :allow_destroy => true

  extend FriendlyId
  friendly_id :organization_name, use: [:slugged, :finders]


  def short_name
    short_name = self.organization_name.split.map(&:first).join
    short_name.upcase
  end


end
