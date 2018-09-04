class Category < ActiveRecord::Base
 #Association
 has_many :user_categories
 has_many :users, through: :user_categories
 has_many :questions
 has_many :tags

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

  def self.search(term)
    if term
      where('name ILIKE ?', "%#{term}%").order('id DESC')
    else
      order('id DESC') 
    end
  end

  def name_with_image
   "<span class='label_name'>#{self.name}</span> <img src=#{self.image}> <span class='marker'></span>".html_safe
  end

  def subscribe?(user)
    self.user_categories.where(user_id: user.id).present?
  end
end
