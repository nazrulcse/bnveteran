class RenameAddressToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :permanent_address, :string
  end
end
