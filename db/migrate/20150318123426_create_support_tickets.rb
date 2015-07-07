class CreateSupportTickets < ActiveRecord::Migration
  def change
    create_table :support_tickets do |t|
      t.string :name
      t.string :email
      t.string :title
      t.text :question

      t.timestamps
    end
  end
end
