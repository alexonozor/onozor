class Tag < ActiveRecord::Base
  belongs_to :category
  has_many :user_tags
  has_many :users, through: :user_tags
  mount_uploader :banner, TagUploader
  mount_uploader :image, TagUploader

  validates_presence_of :name, :image, :description, :banner, :short_description, :category_id
end
