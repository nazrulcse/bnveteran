class Notification < ApplicationRecord
  belongs_to :notification, polymorphic: true
end
