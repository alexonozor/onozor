class CreateProfileProgresses < ActiveRecord::Migration
  def change
    create_table :profile_progresses do |t|
      t.boolean :written_bio, default: false
      t.boolean :updated_question, default: false
      t.boolean :asked_question, default: false
      t.boolean :followed_someone, default: false
      t.integer :user_id

      t.timestamps
    end
  end
end
