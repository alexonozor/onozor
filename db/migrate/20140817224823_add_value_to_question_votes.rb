class AddValueToQuestionVotes < ActiveRecord::Migration
  def change
    add_column :question_votes, :value, :integer
  end
end
