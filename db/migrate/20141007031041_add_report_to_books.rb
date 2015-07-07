class AddReportToBooks < ActiveRecord::Migration
  def change
    add_column :books, :report_flag, :boolean
    add_column :books, :reported_by, :integer
        reversible do |dir|
          dir.up { Book.update_all report_flag: false }
        end
  end
end
