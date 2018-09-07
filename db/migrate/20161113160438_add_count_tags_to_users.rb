class AddCountTagsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :count_tags, :integer, default: 0
  end
end
