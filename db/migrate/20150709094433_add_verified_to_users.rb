class AddVerifiedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :verified_status, :string, :default => nil
    add_column :users, :verification_request, :string, :default => nil
  end
end
