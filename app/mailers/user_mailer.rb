class UserMailer < ActionMailer::Base

  default :from => "noreply@onozor.com"
  def answer_update(answer)
    @question = answer.question
    @question_owner = answer.question.user
    @user = answer.user
    mail :to => @question.user.email,
         :subject => "Your Question Has been Answered - Onozor"
  end
end
