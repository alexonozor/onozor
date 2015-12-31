class NewsLetter < ActionMailer::Base
  require 'pry'
  default :from => "noreply@onozor.com"

  def deliver_questions(latest_question)
    @latest_question = latest_question
    @users = User.all.collect(&:email)
    @users.each do |user|
    mail :to => user.email,
         :subject => "Onozor Digest"
    end
  end
end
