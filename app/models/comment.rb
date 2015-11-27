class Comment < ActiveRecord::Base
  #association
  has_ancestry
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  has_many :activities,  as: :notifier, :foreign_key => 'receiver_id'
  after_create :notify_user

  #validations
  validates_uniqueness_of :body, :message => "Similar comment are not allowed, say somthing different", uniqueness: { scope: :user_id }
  validates_presence_of :body, :commentable_type, :user_id, :commentable_id, :message => "You can't post an empty comment"
  ORDER = ["latest", "reputation"]

  def notify_user
    notified_user = self.commentable.user
    notification_params = Activity.create!(
        :sender_id => self.user.id,
        :receiver_id => notified_user.id,
        :notifier_id => self.id,
        :notifier_type => self.class.name
    )
  end
end
