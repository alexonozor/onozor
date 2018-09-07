class Follower < ActionMailer::Base
  default :from => "noreply@onozor.com"
  def followers_update(following, follower)
    @following = following
    @follower = follower
    mail :to => @following.email,
         :subject => "#{@follower.fullname.titleize} You have a new follower - Onozor"
  end
end
