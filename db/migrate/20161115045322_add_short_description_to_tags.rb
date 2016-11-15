class AddShortDescriptionToTags < ActiveRecord::Migration
  def change
    add_column :tags, :short_description, :text
  end
end
