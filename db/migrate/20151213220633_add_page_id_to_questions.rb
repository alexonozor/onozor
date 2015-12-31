class AddPageIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :page_id, :integer
  end
end
