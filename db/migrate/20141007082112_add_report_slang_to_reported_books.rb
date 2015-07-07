class AddReportSlangToReportedBooks < ActiveRecord::Migration
  def change
    add_column :reported_books, :report_slang, :integer
    add_column :reported_books, :report_adult, :integer
    add_column :reported_books, :report_cist, :integer
    remove_column :reported_books, :report_cause
  end
end
