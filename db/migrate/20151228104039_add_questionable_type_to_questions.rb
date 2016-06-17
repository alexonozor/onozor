class AddQuestionableTypeToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :questionable_type, :string
  end
end
