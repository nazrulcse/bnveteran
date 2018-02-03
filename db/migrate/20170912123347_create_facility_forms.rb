class CreateFacilityForms < ActiveRecord::Migration[5.0]
  def change
    create_table :facility_forms do |t|
      t.references :facility, foreign_key: true
      t.string :title
      t.text :form

      t.timestamps
    end
  end
end
