class AnswerVote < ActiveRecord::Base
  #association
  belongs_to :user
  belongs_to :answer
  after_save :update_answer
  #after_update :update_answer

  #validation
  validates_uniqueness_of :answer_id, scope: :user_id
  validates_inclusion_of :value, in: [1, -1]
  validates_presence_of :user_id, :answer_id, :value
  validate :ensure_not_author

  def ensure_not_author
    errors.add :user_id, "is the author of the Answer" if answer.user_id == user_id
  end

  def self.update_or_create(attributes)
    assign_or_new(attributes).save
  end
  
  def self.assign_or_new(attributes)
    obj = first || new
    obj.assign_attributes(attributes)
    obj
  end

  def update_answer
    answer = Answer.find(self.answer_id)
    answer.update(vote_count: answer.votes)
  end
end
