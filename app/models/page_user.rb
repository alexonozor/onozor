class PageUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :page
  validates :page_id, :uniqueness => { :scope=> :user_id }
end
