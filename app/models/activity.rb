class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :actor, class_name: "User" 
  belongs_to :trackable, polymorphic: true
  scope :seen, -> {where(:seen => true)}
  scope :unseen, -> {where(:seen => false)}
  default_scope { order("created_at DESC") }
end
