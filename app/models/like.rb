# == Schema Information
#
# Table name: likes
#
#  id              :integer          not null, primary key
#  likable_id      :integer
#  likable_type    :string
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  current_user_id :integer
#

class Like < ApplicationRecord
  belongs_to :likable, polymorphic: true
  belongs_to :user, foreign_key: :current_user_id
  has_many :notifications, as: :notification, dependent: :destroy
end
