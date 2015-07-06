class UserMailer < ActionMailer::Base


  default :from => "Inquire.com"

  def answer_update(answer)
    @question = answer.question
    mail :to => @question.user.email,
         :subject => "New question has been added '#{@question.name}'"
  end
end

