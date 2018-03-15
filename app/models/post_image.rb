# == Schema Information
#
# Table name: post_images
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  image      :text
#  caption    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostImage < ApplicationRecord
  belongs_to :post
  mount_uploader :image, AvatarUploader
end
