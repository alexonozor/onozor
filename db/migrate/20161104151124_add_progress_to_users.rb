class AddProgressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :progress, :integer, default: 0
  end
end
