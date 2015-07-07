class AddViewsToBooks < ActiveRecord::Migration
  def change
    add_column :books, :views, :integer, default: 0
    add_index :books, :views
  end
end
