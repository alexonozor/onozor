class Alltag < ActiveRecord::Base
  
   #associations
   belongs_to :user
   belongs_to :question
   
   #validations
   validates_uniqueness_of :name, :message => "Tag already exit!"
   validates_uniqueness_of :description, :message => "Please tell use what your Tag is all about in not more than 50 words"
   validates_length_of :description, :within => 5..200
   validates_presence_of :name, :user_id
   validates_length_of :name, :within => 2..15
   
   #filters
   before_validation :strip_tags

   def strip_tags
    if name.present?
       
     self.name = name.titleize.strip.gsub(' ', '-') 
    end  
   end


end
