class AddExtraFieldToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :designation_type, :integer
  	add_column :users, :rank, :integer
  	add_column :users, :officer_no, :string
  	add_column :users, :date_joining, :date
  	add_column :users, :date_retirement, :date
  	add_column :users, :batch, :string
  	add_column :users, :address, :string
   	add_column :users, :state, :string
	add_column :users, :city, :string
	add_column :users, :country, :string	
  end
end
