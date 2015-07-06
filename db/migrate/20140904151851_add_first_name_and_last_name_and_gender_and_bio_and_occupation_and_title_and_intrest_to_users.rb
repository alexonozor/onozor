class AddFirstNameAndLastNameAndGenderAndBioAndOccupationAndTitleAndIntrestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :gender, :string
    add_column :users, :bio, :text
    add_column :users, :occupation, :string
    add_column :users, :title, :string
    add_column :users, :intrest, :string
  end
end
