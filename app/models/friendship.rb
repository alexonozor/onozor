class Friendship < ActiveRecord::Base
 #association
 belongs_to :user
 belongs_to :friend, :class_name => "User"
 
   #validation
   validates_uniqueness_of :friend
   validate :can_not_follow_your_self

   def can_not_follow_your_self
    errors.add(:base, 'You cannot follow you self') if friend_id == user_id
  end
  

  
end
