class CreateHashtags < ActiveRecord::Migration
  def change
    create_table :hashtags do |t|
      t.string :content
      t.string :tag
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
    add_index :hashtags, :user_id
    add_index :hashtags, :book_id
  end
end
