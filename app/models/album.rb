class Album < ApplicationRecord
  has_many :gallery_photos, dependent: :destroy

  validates_presence_of :name

  accepts_nested_attributes_for :gallery_photos, :allow_destroy => true

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

end
