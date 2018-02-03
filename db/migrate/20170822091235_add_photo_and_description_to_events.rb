class AddPhotoAndDescriptionToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :photo, :string
    add_column :events, :description, :text
  end
end
