class AddViewCountToBooks < ActiveRecord::Migration
  def change
    add_column :books, :view_count, :integer, default: 0
  end
end
