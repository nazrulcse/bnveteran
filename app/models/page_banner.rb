# == Schema Information
#
# Table name: page_banners
#
#  id               :integer          not null, primary key
#  banner_photo     :string
#  menu_bar_item_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class PageBanner < ApplicationRecord
  belongs_to :menu_bar_item
  validates_presence_of :banner_photo, :menu_bar_item_id
  mount_uploader :banner_photo, AvatarUploader
end
