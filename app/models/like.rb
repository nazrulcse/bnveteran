class Like < ApplicationRecord
  belongs_to :likable, polymorphic: true
  belongs_to :user, foreign_key: :current_user_id
  has_many :notifications, as: :notification, dependent: :destroy
end
