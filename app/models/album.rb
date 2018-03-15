# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#

class Album < ApplicationRecord
  has_many :gallery_photos, dependent: :destroy

  validates_presence_of :name

  accepts_nested_attributes_for :gallery_photos, :allow_destroy => true

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

end
