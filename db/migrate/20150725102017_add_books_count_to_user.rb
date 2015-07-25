class AddBooksCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :books_count, :integer, default: 0
  end
end
