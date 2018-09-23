class AddActorIdAndReadAtToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :actor_id, :integer
    add_column :activities, :read_at, :datetime
  end
end
