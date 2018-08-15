class AddAccessTokenAndAccessTokenExpiredAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :access_token, :string
    add_column :users, :access_token_expired_at, :datetime
  end
end
