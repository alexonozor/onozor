class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :body
      t.integer :question_id
      t.integer :user_id
      t.integer :accepted, :defualt => false
      t.text :body_plain
      t.boolean :send_mail, :default => false

      t.timestamps
    end
  end
end
