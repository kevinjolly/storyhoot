class RemoveReportedByFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :reported_by, :integer
  end
end
