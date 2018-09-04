class UserCategory < ActiveRecord::Base
  belongs_to :user
  belongs_to :category, counter_cache: :subscribers_count
  validates :user_id, :uniqueness => { :scope => :category_id, message: "User has already subscribed to this community" }
end
