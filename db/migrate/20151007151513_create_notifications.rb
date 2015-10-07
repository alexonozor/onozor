class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.references :notifiable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
