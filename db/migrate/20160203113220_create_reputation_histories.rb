class CreateReputationHistories < ActiveRecord::Migration
  def change
    create_table :reputation_histories do |t|
      t.string :user_id
      t.string :context
      t.integer :points
      t.integer :reputation
      t.integer :vote_id
      t.integer :answer_id

      t.timestamps
    end
  end
end
