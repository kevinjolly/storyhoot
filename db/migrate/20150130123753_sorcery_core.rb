class SorceryCore < ActiveRecord::Migration
  def change
    add_column :users, :crypted_password, :string
    add_column :users, :salt, :string
    remove_column :users, :password_digest, :string
    remove_column :users, :auth_token, :string
    remove_column :users, :password_reset_token, :string
    remove_column :users, :password_reset_sent_at, :datetime
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end