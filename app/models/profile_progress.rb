class ProfileProgress < ActiveRecord::Base
  belongs_to :user

  def self.save_values(user)
    user.progress += 20
    user.save!
  end

  def self.update_profile_for_question(user)
    user.profile_progress.update!(asked_question: true)
    save_values(user)
  end

  def self.update_profile_for_upvoted_content(user)
    user.profile_progress.update!(voted_for_content: true)
    save_values(user)
  end

  def self.update_profile_for_upvoted_content(user)
    user.profile_progress.update!(voted_for_content: true)
    save_values(user)
  end

  def self.update_profile_for_answer_question(user)
    user.profile_progress.update!(answered_question: true)
    save_values(user)
  end

  def self.update_profile_for_following_someone(user)
    user.profile_progress.update!(followed_someone: true)
    save_values(user)
  end

  def self.update_profile_for_bio_updated(user)
    user.profile_progress.update!(written_bio: true)
    save_values(user)
  end


end
