class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers => [:facebook, :google_oauth2]

  mount_uploader :avatar, AvatarUploader
  extend FriendlyId
  friendly_id :username, use: :slugged

  #association
  has_many :activities, :foreign_key => 'receiver_id'
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
  has_many :user_categories
  has_many :categories, through: :user_categories
  has_many :comments
  has_many :direct_messages

  #validations
  validates_presence_of :username
  validates_presence_of :avatar, :on => :account_update
  validates_length_of :username, :within => 4..10, :on => :account_update
  validates_uniqueness_of :username, :on => :account_update

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
       # binding.pry;
      user.username = auth.info.name.split(' ')[0] + auth.info.name.split(' ')[1]
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.gender = auth['extra']['raw_info']['gender']
      user.remote_avatar_url = auth.info.image
    end
  end

  def self.new_with_session(params, session)
    if session['devise.user_attributes']
      new(session['devise.user_attributes'], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

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
   ("#{first_name}" ' ' "#{last_name}".capitalize if first_name && last_name.present?) || username
 end

def fullname?
  fullname.present? ? true : false
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
      last_requested_at > (Time.now - 5.minutes) ? true : false
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

  def category_feeds
    feeds = self.categories.map(&:questions) << feed
     @alex = feeds.flatten.uniq.sort! {|a, b|  b.created_at.to_i <=> a.created_at.to_i }
  end

  def self.people_you_may_know(current_user)
    if current_user
      q = "Select users.* from users, user_categories where user_categories.user_id = users.id and user_categories.category_id in (
          select user_categories.category_id from user_categories where user_categories.user_id = #{current_user.id}
      ) and users.id not in (#{current_user.id}) and users.id not in (
          SELECT users.id FROM users INNER JOIN relationships ON users.id = relationships.followed_id and relationships.follower_id = #{current_user.id}
      ) group by users.id limit 5".gsub(/\n|\s{2,}/, "")

      # Finds a user in each category i follow
      User.find_by_sql(q)
    end
  end


  def recent_activities(limit)
    activities.order('created_at DESC').limit(limit)
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
