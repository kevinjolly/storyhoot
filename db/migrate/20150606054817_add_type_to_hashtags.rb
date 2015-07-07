class AddTypeToHashtags < ActiveRecord::Migration
  def change
    add_column :hashtags, :hashtag_type, :string
  end
end
