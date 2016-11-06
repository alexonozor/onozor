class AddVotedForContentToProfileProgresses < ActiveRecord::Migration
  def change
    add_column :profile_progresses, :voted_for_content, :boolean, default: false
  end
end
