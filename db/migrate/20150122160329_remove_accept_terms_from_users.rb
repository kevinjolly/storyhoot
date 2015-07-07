class RemoveAcceptTermsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :accept_terms, :boolean
  end
end
