class RemoveUploadsAndReportedBooks < ActiveRecord::Migration
  def change
    drop_table :uploads
    drop_table :reported_books
  end
end
