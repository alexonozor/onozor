class AddOnlyFollowersFeedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :only_follower_feed, :boolean, :default => :false
  end
end
