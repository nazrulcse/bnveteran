class AddPresentStateCityCountryToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :present_state, :string
    add_column :users, :present_city, :string
    add_column :users, :present_country, :string
  end
end
