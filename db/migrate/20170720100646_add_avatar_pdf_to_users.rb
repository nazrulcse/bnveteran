class AddAvatarPdfToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :avatar_pdf, :string
  end
end
