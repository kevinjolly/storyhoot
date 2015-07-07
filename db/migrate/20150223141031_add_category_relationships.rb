class AddCategoryRelationships < ActiveRecord::Migration
  def change
    add_column :books, :category_id, :integer
    add_column :categories, :user_id, :integer
    add_index :categories, :name
  end
end
