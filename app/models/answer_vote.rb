class AnswerVote < ActiveRecord::Base
  #association
  belongs_to :user
  belongs_to :answer

  #validation
  validates_uniqueness_of :answer_id, scope: :user_id
  validates_inclusion_of :value, in: [1, -1]
  validates_presence_of :user_id, :answer_id, :value
  # validate :ensure_not_author

  def ensure_not_author
    errors.add :user_id, "is the author of the Answer" if answer.user_id == user_id
  end

end
