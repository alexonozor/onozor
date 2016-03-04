class Reputation

  def self.toggle_acceptance(question, answer)
    if question.accepted_answer == answer #if this returns true meaning the answer has already been accepted or the question has an accepted answer.
      id = reject_answer(question, answer)
    else
      id = accept_answer(question, answer)
    end
  end


  def self.accept_answer(question, answer)
    answer_user = answer.user
    if question.accepted_answer.present? # if the question has an accepted answer, lets reject
      reject_answer(question, answer)
    end
    question.attributes = { :answer_id => answer.id }
    question.save(:validate => false)
    update_user_reputation(5, answer_user, answer)
  end

 def self.reject_answer(question, answer)
   if question.user != question.accepted_answer.user
     question.accepted_answer.user.reputation = new_reputation
     question.accepted_answer.user.save(:validate => false)
   end
   question.attributes = { :answer_id => 0 }
   question.save(:validate => false)
 end

 def update_user_reputation(points, user)
    user.reputation + points
    question.save(:validate => false)
    ReputationHistory.update!(user_id: user, answer_id: answer, question_id: answer.question_id)
 end
end
