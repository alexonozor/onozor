class Comment < ActiveRecord::Base
  
  #association
  has_ancestry
  belongs_to :user
  belongs_to :commentable, :polymorphic => true

  #validations
  validates_presence_of :body, :commentable_type, :user_id, :commentable_id


  validates_length_of :body, :within => 10..280

  ORDER = ["latest", "reputation"]

end
