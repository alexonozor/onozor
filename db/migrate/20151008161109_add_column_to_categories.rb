class AddColumnToCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :user_id, :integer
  end
end
