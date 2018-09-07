class AddAncestryToQuestions < ActiveRecord::Migration
   def self.up
    add_column :questions, :ancestry, :string
    add_index :questions, :ancestry
  end

  def self.down
    remove_index :questions, :ancestry
    remove_column :questions, :ancestry
  end
end
