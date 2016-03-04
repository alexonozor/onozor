class AddLongitudeAndLatitudeToPages < ActiveRecord::Migration
  def change
    add_column :pages, :latitude, :float
    add_column :pages, :longitude, :float
  end
end
