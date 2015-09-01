class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_paper_trail

  #avatar upload
  if Rails.env.development?
  has_attached_file :avatar,
                    :storage => :dropbox,
                    :dropbox_credentials => "#{Rails.root}/config/dropbox.yml",
                    :styles => { :medium => "150x150#", :thumbs => "100x100#", :thumbnails => "70x70#",
  :thumb => "50x50#", :home => "30x30>" }, :default_url => ""
  validates_attachment :avatar,
  :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] },
                       :dropbox_options => {
                           :path => proc { |style| "#{style}/#{id}_#{avatar.original_filename}" }
   }
  else
    has_attached_file :avatar,
                      :styles => { :medium => "150x150#", :thumbs => "100x100#", :thumbnails => "70x70#",
                                   :thumb => "50x50#", :home => "30x30>" }, :default_url => ""
    validates_attachment :avatar,
                         :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
  end

  extend FriendlyId
  friendly_id :username, use: :slugged

  #association
  has_many :questions
  has_many :replies, :through => :questions, :source => :answers
  has_many :alltags
  has_many :answers
  has_many :favourites
  has_many :favourite_questions, :through => :favourites, :source => :question
  has_many :question_votes, :dependent => :destroy
  has_many :answer_votes, :dependent => :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships
  has_many :category 
  has_many :comments  

  #validations
  validates_presence_of :username
  validates_presence_of :avatar, :on => :account_update
  validates_length_of :username, :within => 4..10, :on => :account_update
  validates_uniqueness_of :username, :on => :account_update


  #scoping
  scope :online, -> {where('last_requested_at > ? ', Time.now - 5.minute)}

  def can_vote_for?(question)
    question_votes.build(value: 1, question: question).valid?
  end

 def can_vote?(answer)
    answer_votes.build(value: 1, answer: answer).valid?
  end

 

 def self.search(search)
    where("username like ?", "%#{search}%")
  end

   




  #filters
  before_validation :strip_down_username


 #general methods
  def strip_down_username
     if username.present?
        self.username.strip!
        self.username.downcase!
     end
  end

 def fullname
   "#{first_name}" ' ' "#{last_name}".capitalize if first_name && last_name.present?
 end

def fullname?
   if fullname
     return true
   else
     return false
   end
end

 def latest_questions
    Question.find_all_by_user_id(self.id, :limit => 5, :order => 'created_at desc')
  end

  def latest_answers
    Question.find(:all, :limit => 5, :order => "answers.created_at desc", :joins => :answers, :conditions => ['answers.user_id=?', self.id])
  end

  def count_view!
    self.views = self.views.nil? ? 0 : (self.views + 1)
    self.save(:validate => false)
  end

  def is_online?
    if last_requested_at > (Time.now - 5.minutes)
      true
    else
      false
    end
  end

  def banned?
   banned_at
  end

 
 def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

   def feed
    Question.from_users_followed_by(self)
  end

 
  #schema
 # t.string   "email",                  default: "", null: false
 # t.string   "encrypted_password",     default: "", null: false
 # t.string   "reset_password_token"
 # t.datetime "reset_password_sent_at"
 # t.datetime "remember_created_at"
 # t.integer  "sign_in_count",          default: 0,  null: false
 # t.datetime "current_sign_in_at"
 # t.datetime "last_sign_in_at"
 # t.string   "current_sign_in_ip"
 # t.string   "last_sign_in_ip"
 # t.datetime "created_at"
 # t.datetime "updated_at"
 # t.string   "username"
 # t.string   "avatar"
 # t.integer  "views",                  default: 0
 # t.datetime "last_requested_at"
end
