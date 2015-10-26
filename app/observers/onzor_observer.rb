class OnzorObserver < ActiveRecord::Observer
  observe Answer, Comment

  def after_create(answer)
    UserMailer.answer_update(answer).deliver if answer.question.send_mail
  end

  def after_save(comment)
    UserMailer.comment_update(question).deliver
  end

end