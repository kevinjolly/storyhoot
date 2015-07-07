class CreateReportedBooks < ActiveRecord::Migration
  def change
    create_table :reported_books do |t|
      t.integer :book_id
      t.integer :user_id
      t.integer :report_cause

      t.timestamps
    end
    add_index :reported_books, :user_id
    add_index :reported_books, :book_id
    add_index :reported_books, [:user_id, :book_id], unique:true
  end
end
