class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :name
      t.text :body
      t.integer :user_id
      t.integer :views, :default => 0
      t.integer :answers_count, :default => 0
      t.string :permalink
      t.integer :answer_id
      t.boolean :send_mail, :default => false

      t.timestamps
    end
  end
end
