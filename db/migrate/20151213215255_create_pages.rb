class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.text :address
      t.string :zip_code
      t.string :phone
      t.integer :privacy_id
      t.string :website
      t.text :long_description
      t.text :short_description
      t.string :cover_picture
      t.string :logo
      t.integer :user_id
      t.integer :page_type_id

      t.timestamps
    end
  end
end
