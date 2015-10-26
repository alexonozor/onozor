class UserMailer < ActionMailer::Base
require 'pry'
  default :from => "noreply@onozor.com"
  def answer_update(answer)
    @question = answer.question
    @question_owner = answer.question.user
    @user = answer.user
    mail :to => @question.user.email,
         :subject => "Your Question Has been Answered - Onozor"
  end

  def comment_update(comment)
    @commenter = comment.user
    @commentable_type = comment.commentable_type
    commentable_type = @commentable_type.constantize
    commentable_id = comment.commentable_id
    @find_parent = commentable_type.find(commentable_id)
    mail :to => @find_parent.user.email,
         :subject => "New reply to your #{@commentable_type.downcase} - Onozor"
  end
end
