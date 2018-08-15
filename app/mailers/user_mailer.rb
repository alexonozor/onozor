class UserMailer < ActionMailer::Base
  skip_before_filter :restrict_access
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

  def login_link(user)
    @user = user

    mail to: @user.email, subject: 'Sign-in into Onozor.com'
  end
end
