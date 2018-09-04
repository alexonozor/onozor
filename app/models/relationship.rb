class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, presence: true
  validates :followed_id, presence: true

  # after_validation :update_profile_progress
  # after_create :notify_follower
  #
  # def notify_follower
  #
  # end

  def update_profile_progress
     ProfileProgress.update_profile_for_following_someone(self.follower) unless self.follower.have_followed_someone?
  end
end
