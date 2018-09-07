class CreateDirectMessages < ActiveRecord::Migration
  def change
    create_table :direct_messages do |t|
      t.string :created_by
      t.string :title
      t.string :body
      t.belongs_to :user
      t.timestamps
    end if !ActiveRecord::Base.connection.table_exists? 'direct_messages'
  end
end
