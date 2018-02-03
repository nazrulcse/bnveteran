class RemoveNotificationImageFromFacilities < ActiveRecord::Migration[5.0]
  def change
    remove_column :facilities, :notification_image, :string
  end
end
