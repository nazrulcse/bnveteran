class CreateVisitors < ActiveRecord::Migration[5.0]
  def change
    create_table :visitors do |t|
      t.string :address
      t.date :date

      t.timestamps
    end
  end
end
