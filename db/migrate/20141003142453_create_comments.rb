class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :book_id
      t.integer :user_id
      t.string :username

      t.timestamps
    end
  end
end
