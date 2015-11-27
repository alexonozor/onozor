class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :notifier, polymorphic: true
end
