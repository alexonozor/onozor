class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :notifier_id
      t.string :notifier_type

      t.timestamps
    end
  end
end
