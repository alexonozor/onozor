class Page < ActiveRecord::Base
  attr_accessor :profile_complete, :timeline_height, :timeline_position
  is_impressionable
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  mount_uploader :logo, LogoUploader
  mount_uploader :cover_picture, CoverPictureUploader
  has_many   :page_users
  has_many   :users, :through => :page_users
  has_many   :questions
  belongs_to :page_type
  belongs_to :user
  belongs_to :privacy
  has_many   :impressions, :as=>:impressionable
  has_many   :page_invites
  #validation
  validates_presence_of :name, :zip_code, :privacy_id, :website, :address, :short_description

  def has_current_user_liked_this_page?(user)
    self.users.include?(user)
  end
  
  def total_impression
    self.impressionist_count(:filter=>:ip_address)
  end

  def view_count_yesterday
    impressions.where("created_at >= ? AND created_at < ?", 1.day.ago.beginning_of_day, 1.day.ago.end_of_day).size
  end
   
  def view_count_this_week
    impressions.where("created_at >= ? AND created_at < ?",  Time.now.beginning_of_week, Time.now.end_of_week).size
  end 

  def view_count_for_the_month
    impressions.where("created_at >= ? AND created_at < ?",  Time.now.beginning_of_month, Time.now.end_of_month).size
  end
  
  def check_if_profile_is_complete?
    if self.cover_picture.present? && self.cover_picture.present?
      self.profile_complete = true
    else
      self.profile_complete = false
    end
  end

  def timeline_height
   if check_if_profile_is_complete?
     self.timeline_height = 315
   else
    self.timeline_height = 200
   end  
  end

  def invite_friends_to_page(page, current_user)
    a = "Select * from users, page_users Where page_users.user_id not in (Select user_id from relationships where relationships.followed_id = #{current_user.id})"
     User.find_by_sql(a)
  end

end
