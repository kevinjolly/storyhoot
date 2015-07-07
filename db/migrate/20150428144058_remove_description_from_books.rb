class RemoveDescriptionFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :description, :string
  end
end
