class AddAnsweredQuestionToProfileProgresses < ActiveRecord::Migration
  def change
    add_column :profile_progresses, :answered_question, :boolean, default: false
  end
end
