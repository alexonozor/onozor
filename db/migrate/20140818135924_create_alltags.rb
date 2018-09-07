class CreateAlltags < ActiveRecord::Migration
  def change
    create_table :alltags do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.integer :question_id

      t.timestamps
    end
  end
end
