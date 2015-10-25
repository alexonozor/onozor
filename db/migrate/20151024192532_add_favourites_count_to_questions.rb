class AddFavouritesCountToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :favourites_count, :integer, default: 0
  end
end
