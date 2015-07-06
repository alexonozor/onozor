class QuestionVote < ActiveRecord::Base
  #association
  belongs_to :user
  belongs_to :question

  #validation
  validates_uniqueness_of :question_id, scope: :user_id
  validates_presence_of :user_id, :question_id, :value
  validates_inclusion_of :value, in: [1, -1]
  validate :ensure_not_author

  def ensure_not_author
    errors.add :user_id, "is the author of the question" if question.user_id == user_id
  end
end
