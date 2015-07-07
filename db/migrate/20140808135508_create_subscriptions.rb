class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :author_id
      t.integer :subscriber_id

      t.timestamps
    end
    add_index :subscriptions, :author_id
    add_index :subscriptions, :subscriber_id
    add_index :subscriptions, [:author_id, :subscriber_id], :unique => true
  end
end
