class ProfileProgress < ActiveRecord::Base
  belongs_to :user

  def self.update_profile_for_question(user)
    user.profile_progress.update!(asked_question: true)
    user.progress += 10;
    user.save!
  end

  def self.update_profile_for_upvoted_content(user)
    user.profile_progress.update!(voted_for_content: true)
    user.progress += 10;
    user.save!
  end
end
