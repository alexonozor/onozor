class RemoveReputationFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :reputation, :integer
  end
end
