class UserTag < ActiveRecord::Base
  belongs_to :user
  belongs_to :tag
  validates_presence_of :user_id, :tag_id
  validates_uniqueness_of :user_id, :scope => :tag_id
end
