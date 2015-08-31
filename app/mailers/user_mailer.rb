class UserMailer < ActionMailer::Base


  default :from => "alex.obogbare@andela.com"

  def answer_update(answer)
    @question = answer.question
    @question_owner = answer.question.user
    @user = answer.user
    mail :to => @question.user.email,
         :subject => "Your Question Has been Answered - Inquire"
  end
end

