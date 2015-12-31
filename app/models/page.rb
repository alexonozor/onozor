class Page < ActiveRecord::Base
  mount_uploader :logo, LogoUploader
  mount_uploader :cover_picture, CoverPictureUploader
  has_many :page_users
  has_many :users, :through => :page_users
  has_many :questions
  belongs_to :page_type
  belongs_to :user
  belongs_to :privacy

  #validation
  validates_presence_of :name, :zip_code, :privacy_id, :website, :address, :short_description

end
