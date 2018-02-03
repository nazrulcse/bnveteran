class AddNotificationImagesFromFacilities < ActiveRecord::Migration[5.0]
  def change
    add_column :facilities, :notification_images, :json
  end
end
