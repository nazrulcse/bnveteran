class AddTopicCreatorNameToNotification < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :topic_creator_name, :string
  end
end
