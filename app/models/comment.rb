class Comment < ActiveRecord::Base

  #association
  has_ancestry
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  after_save :send_mail_to_the_owner_of_the_answer


  #validations
  validates_uniqueness_of :body, :message => "Similar comment are not allowed, say somthing different", uniqueness: { scope: :user_id }
  validates_presence_of :body, :commentable_type, :user_id, :commentable_id, :message => "You can't post an empty comment"
  ORDER = ["latest", "reputation"]

  def send_mail_to_the_owner_of_the_answer
     UserMailer.comment_update(self).deliver
  end

end
