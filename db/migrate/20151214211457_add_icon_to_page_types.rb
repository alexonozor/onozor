class AddIconToPageTypes < ActiveRecord::Migration
  def change
    add_column :page_types, :icon, :string
  end
end
