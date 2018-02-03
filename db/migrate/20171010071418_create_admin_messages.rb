class CreateAdminMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_messages do |t|
      t.string :subject
      t.text :content

      t.timestamps
    end
  end
end
