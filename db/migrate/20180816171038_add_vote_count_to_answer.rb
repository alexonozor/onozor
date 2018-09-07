class AddVoteCountToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :vote_count, :integer, default: 0
  end
end
