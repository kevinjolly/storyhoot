class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
    add_index :likes, :user_id
    add_index :likes, :book_id
    add_index :likes, [:book_id, :user_id], unique:true
  end
end
