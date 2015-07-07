class CreateBulletins < ActiveRecord::Migration
  def change
    create_table :bulletins do |t|
      t.belongs_to :user, index: true
      t.string :content
      t.string :url

      t.timestamps
    end
  end
end
