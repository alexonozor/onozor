class AddSubscribersCountToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :subscribers_count, :integer, default: 0
  end
end
