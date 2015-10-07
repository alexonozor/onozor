class Category < ActiveRecord::Base
 #Association 
 belongs_to :user
 has_many :questions
 
 #callbacks
 before_validation :set_permalink

 #validations
  # validates_presence_of :user_id, :description, :name
  # validates_length_of   :name, :within => 10..30, :uniqueness => true
  # validates_length_of   :description, :minimum => 70, :uniqueness => true

 #friendlyId
 extend FriendlyId
 friendly_id :permalink, use: :slugged

 #general
  def set_permalink
    self.permalink = name.downcase.gsub(/[^0-9a-z]+/, ' ').strip.gsub(' ', '-') if name
  end

  def name_with_image
   "<span class='label_name'>#{self.name}</span> <img src=#{self.image}> <span class='marker'></span>".html_safe
  end
end
