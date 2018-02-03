class PageBanner < ApplicationRecord
  belongs_to :menu_bar_item
  validates_presence_of :banner_photo, :menu_bar_item_id
  mount_uploader :banner_photo, AvatarUploader
end
