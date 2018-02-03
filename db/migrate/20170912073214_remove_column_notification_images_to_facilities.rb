class RemoveColumnNotificationImagesToFacilities < ActiveRecord::Migration[5.0]
  def change
    remove_column :facilities, :notification_images
  end
end
