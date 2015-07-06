class AddUsernameAndAvatarAndViewsAndLastRequestedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :avatar, :string
    add_column :users, :views, :integer, :default => 0
    add_column :users, :last_requested_at, :datetime
  end
end
