class AddQuestionCountToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :question_count, :integer, default: 0, null: false
  end
end


# Category.find_each { |c| Category.reset_counters(c.id, :questions)  }
# Category.find_each { |c| Category.reset_counters(c.id, :users)  }