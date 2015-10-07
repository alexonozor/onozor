class Follower < ActionMailer::Base
  default :from => "noreply@onozor.com"
  def followers_update(following, follower)
    @following = following
    @follower = follower
    mail :to => @following.email,
         :subject => "#{@follower.username.titleize} is now following you - Onozor"
  end
end
