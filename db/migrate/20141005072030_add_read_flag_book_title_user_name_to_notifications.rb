class AddReadFlagBookTitleUserNameToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :read_flag, :integer
    add_column :notifications, :book_title, :string
    add_column :notifications, :user_name, :string
  end
end
