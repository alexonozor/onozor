class ProfileProgress < ActiveRecord::Base
  belongs_to :user

  def self.update_profile_for_question(user)
    binding.pry
    user.profile_progress.update!(asked_question: true)
    user.progress += 10;
    user.save!
  end
end
