class AddSlugToSimpleHashtagHashtags < ActiveRecord::Migration[5.0]
  def change
    add_column :simple_hashtag_hashtags, :slug, :string
    add_index :simple_hashtag_hashtags, :slug, unique: true
  end
end
