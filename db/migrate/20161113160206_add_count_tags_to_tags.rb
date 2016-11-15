class AddCountTagsToTags < ActiveRecord::Migration
  def change
    add_column :tags, :count_users, :integer, default: 0
  end
end
