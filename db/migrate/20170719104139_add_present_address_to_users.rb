class AddPresentAddressToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :present_address, :string
  end
end
