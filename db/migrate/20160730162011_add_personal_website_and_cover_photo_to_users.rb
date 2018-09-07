class AddPersonalWebsiteAndCoverPhotoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :personal_website, :string
    add_column :users, :cover_photo, :string
  end
end
