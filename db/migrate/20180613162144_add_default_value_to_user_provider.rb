class AddDefaultValueToUserProvider < ActiveRecord::Migration
  def change
    change_column_default :users, :provider, "email"
  end
end
