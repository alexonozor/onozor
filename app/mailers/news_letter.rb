class NewsLetter < ActionMailer::Base


  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.news_letter.deliver_letter.subject
  #
  default :from => "noreply@onozor.com"
  def deliver_letter(latest_question)
    @latest_question = latest_question
    user = User.all.collect(&:email).join(",")
      mail :to => user,
           :subject => "Onozor Digest"
  end
end
