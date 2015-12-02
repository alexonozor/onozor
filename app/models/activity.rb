class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :trackable, polymorphic: true

  default_scope  order("created_at DESC")
  scope :seen, -> {where(:seen => true)}
  scope :unseen, -> {where(:seen => false)}

end
