class AddPictureToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :picture, :string
  end
end
