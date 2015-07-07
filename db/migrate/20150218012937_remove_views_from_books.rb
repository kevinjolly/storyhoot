class RemoveViewsFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :views, :integer
  end
end
