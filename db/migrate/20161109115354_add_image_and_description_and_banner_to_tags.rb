class AddImageAndDescriptionAndBannerToTags < ActiveRecord::Migration
  def change
    add_column :tags, :image, :string
    add_column :tags, :description, :text
    add_column :tags, :banner, :string
  end
end
