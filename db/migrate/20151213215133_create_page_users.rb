class CreatePageUsers < ActiveRecord::Migration
  def change
    create_table :page_users do |t|
      t.integer :user_id, index: true
      t.integer :page_id, index: true

      t.timestamps
    end
  end
end
