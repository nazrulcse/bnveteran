# == Schema Information
#
# Table name: notifications
#
#  id                 :integer          not null, primary key
#  topic_id           :integer
#  user_id            :integer
#  checked            :boolean
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  notification_type  :string
#  notification_id    :integer
#  topic_creator_name :string
#  topic_creator_id   :integer
#

class Notification < ApplicationRecord
  belongs_to :notification, polymorphic: true
end
