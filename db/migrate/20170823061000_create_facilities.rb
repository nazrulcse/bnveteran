class CreateFacilities < ActiveRecord::Migration[5.0]
  def change
    create_table :facilities do |t|
      t.string :title
      t.text :description
      t.string :form_title
      t.string :upload_form
      t.string :notification_image

      t.timestamps
    end
  end
end
