class OnzorObserver < ActiveRecord::Observer
  observe Answer, Comment

  def after_create(answer)
  	UserMailer.answer_update(answer).deliver if should_email_user?(answer)
  end

  def after_save(comment)
  	UserMailer.comment_update(comment).deliver if comment.is_a?(Comment)
  end

  private
  def should_email_user?(answer)
  	answer.question.send_mail & answer.is_a?(Answer)
  end

end