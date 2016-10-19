class AddCityAndCountryAndTwitterUrlAndFacebookUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :twitter_url, :string
    add_column :users, :facebook_url, :string
  end
end
