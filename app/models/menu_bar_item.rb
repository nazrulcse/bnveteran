class MenuBarItem < ApplicationRecord
  has_many :page_banners, dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :name

  accepts_nested_attributes_for :page_banners, :allow_destroy => true
end
