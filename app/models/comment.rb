class Comment < ActiveRecord::Base
  
  #association
  has_ancestry
  belongs_to :user
  belongs_to :commentable, :polymorphic => true

  #validations
  validates_uniqueness_of :body, :message => "Similar comment are not allowed, say somthing different"
  validates_presence_of :body, :commentable_type, :user_id, :commentable_id, :message => "You can't post an empty comment"


  validates_length_of :body, :within => 10..280

  ORDER = ["latest", "reputation"]

end
