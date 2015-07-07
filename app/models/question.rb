class Question < ActiveRecord::Base

 #filters
  acts_as_taggable_on :tags
  acts_as_tagger
  before_validation :set_permalink
  #has_paper_trail
  has_ancestry

 extend FriendlyId
  friendly_id :name, use: :slugged

 #association
 belongs_to :user
 belongs_to :category
 has_many :alltags
 has_many :answers, :dependent => :destroy
 has_many :favourites, :dependent => :destroy
 has_many :question_votes, :dependent => :destroy
 has_many :comments, :as => :commentable, :dependent => :destroy

 #validation
 validates_presence_of :name, :body, :user_id #:tag_list
 validates_length_of   :name, :within => 20..200
 validates_length_of   :body, :within => 70...20000
 validates_length_of   :tag_list, :minimum => 2, :maximum => 8
 validates_uniqueness_of :name, :body

  #scope
  default_scope ->{ order('created_at DESC') }
  scope :overflowed, :order => "questions.created_at DESC", :conditions => ["answers_count > ?", "10"]
  scope :latest, :order => "questions.created_at DESC"
  scope :hot, :order => "answers_count DESC, questions.updated_at DESC"
  scope :active, :order => "questions.updated_at DESC, answers_count DESC"
  scope :unanswered, :order => "questions.created_at DESC", :conditions => ["answers_count = ?", "0"]
  scope :answered, :order => "questions.created_at DESC", :conditions => ["answers_count > ?", "0"]

  def self.by_votes
    select('questions.*, coalesce(value, 0) as votes').
        joins('left join question_votes on question_id=questions.id').
        order('votes desc')
  end

  def votes
    read_attribute(:votes) || question_votes.sum(:value)
  end

  #general
  def set_permalink
    self.permalink = name.downcase.gsub(/[^0-9a-z]+/, ' ').strip.gsub(' ', '-') if name
  end

  def update_views!
    number_of_views = self.views.nil?? 0 : self.views
    self.views = number_of_views + 1
    self.save(:validate => false)
  end



 def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end


  def vote_class
   self.votes.to_i
  end
  
 def vote_status
   case vote_class
    when 11..30 then 'text-success'
    when 8..10 then 'text-primary'
    when 7 then 'text-warning'
     else
      'text-danger'      
    end
 end

  def answers_count_color
    self.answers_count.to_i
  end

  def answer_count_color
    case answers_count_color
      when  11..1000  then 'rgba(0, 225, 0, 0.50)'
      else
        'rgba(103, 83, 135, 0.20)'
    end
  end

  def favourited?(user)
    Favourite.find_by_user_id_and_question_id(user.id, self).present?
  end

  



 #schema
 #t.string   "name"
 #t.text     "body"
 #t.integer  "user_id"
 #t.integer  "views",         default: 0
 #t.integer  "answers_count", default: 0
 #t.string   "permalink"
 #t.integer  "answer_id"
 #t.boolean  "send_mail",     default: false
 #t.datetime "created_at"
 #t.datetime "updated_at"

end
