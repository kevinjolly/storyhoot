class AddNotifierToBulletins < ActiveRecord::Migration
  def change
    add_column :bulletins, :notifier, :integer
    add_index :bulletins, :notifier 
  end
end
