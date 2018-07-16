class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User

  devise :database_authenticatable, :registerable, :validatable,
         :recoverable, :rememberable, :trackable, :omniauthable,
         :omniauth_providers => [:facebook, :google_oauth2, :twitter, :linkedin]
         

  mount_uploader :avatar, AvatarUploader

  def confirmed_at
    Time.now.utc
  end

  extend FriendlyId
  friendly_id :username, use: :slugged
  after_create :create_profile_progress_account


  #association
  has_many :owned_pages, class_name: 'Page', :foreign_key => 'user_id'
  has_many :page_users
  has_many :pages, :through => :page_users
  has_many :activities
  has_many :questions
  has_many :replies, :through => :questions, :source => :answers
  has_many :answers
  has_many :answered_questions, through: :answers, :source => :question
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
  has_many :page_invites
  has_one  :profile_progress
  has_many :user_tags, dependent:  :destroy
  has_many :tags,  -> { uniq }, through: :user_tags

  #validations
  #validates_presence_of :username
  validates_presence_of :avatar, :on => :account_update
  validates_length_of :username, :within => 4..10, :on => :account_update
  validates_uniqueness_of :username, :on => :account_update

  def create_profile_progress_account
     self.create_profile_progress
  end

  def self.is_provider_from_twitter?(auth)
    if auth.provider == 'twitter'
      return true
    else
      return false
    end
  end

  # Friends contain both your followers and your following
  def friends(user)
    user_friends = "SELECT users.*
                      from users
                      INNER JOIN relationships
                      ON relationships.follower_id = #{user.id}
                     UNION
                      SELECT users.*
                      from users
                      INNER JOIN relationships
                      ON relationships.followed_id = #{user.id}"
    User.find_by_sql(user_friends)
  end




  def self.from_omniauth(auth)
    # user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      if auth.provider == "facebook"
        save_facebook_details(auth, user)
      elsif auth.provider == "twitter"
        save_twitter_details(auth, user)
      elsif auth.provider == "google_oauth2"
        save_google_details(auth, user)
      elsif auth.provider == "linkedin"
        save_linkedin_details(auth, user)
      else
        raise "provider not find"
      end
    end
  end




  def self.save_twitter_details(auth, user)
    # binding.pry
    user.username = auth.info.nickname
    user.password = Devise.friendly_token[0,20]
    user.first_name = auth['info']['name'].split(' ')[0]
    user.last_name =  auth.info.name.split(' ')[1]
    user.remote_avatar_url = auth['info']['image']
    user.bio = auth.info.description
    user.location = auth.info.location if auth.info.location.present?
    user.twitter_url = auth['info']['urls']['Twitter']
    user.personal_website = auth['info']['urls']['Website']
    user.save
  end


   def self.save_facebook_details(auth, user)
     user.username =  user.username = auth.info.name.split(' ')[0] + auth.info.name.split(' ')[1]
     user.email = auth.info.email
     user.password = Devise.friendly_token[0,20]
     user.first_name = auth.info.first_name
     user.last_name  = auth.info.last_name
     user.gender =  auth['extra']['raw_info']['gender']
     user.remote_avatar_url = auth['info']['image']
     user.save
   end



   def self.save_linkedin_details(auth, user)
     user.username = auth['info']['nickname']
     user.email = auth['info']['email']
     user.password = Devise.friendly_token[0,20]
     user.first_name = auth['info']['name'].split(' ').first
     user.last_name =  auth['info']['name'].split(' ').last
     user.remote_avatar_url = auth[:extra][:raw_info][:pictureUrls][:values].first
     user.bio = auth['info']['description']
     user.country = auth['info']["location"]['name']
     user.save
   end


   def self.save_google_details(auth, user)
     user.username = auth['extra']['raw_info']["given_name"]
     user.first_name = auth['info']['first_name']
     user.last_name = auth['info']['last_name']
     user.email = auth['info']['email']
     user.password = Devise.friendly_token[0,20]
     user.remote_avatar_url = auth['info']['image']
     user.gender = auth['extra']['raw_info']['gender']
     user.save

   end



    # def self.new_with_session(params, session)
    #   binding.pry
    #   if session['devise.user_attributes']
    #     new(session['devise.user_attributes'], without_protection: true) do |user|
    #       user.attributes = params
    #       user.valid?
    #     end
    #   else
    #     super
    #   end
    # end

  def password_required?
    super && provider.blank?
  end

  def email_required?
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
   ("#{first_name}" ' ' "#{last_name}".titleize if first_name && last_name.present?) || username
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

  def is_the_owner?(current_user, question)
    return true if  (current_user.id == question.user.id) || current_user.admin?
    return false
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

  def following_tag?(tag)
    self.tags.include?(tag)
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
    User.find_by_sql(q)
    end
  end

  def invite_friends(current_user, current_page)
    user_friends = friends(current_user).map(&:id).join(', ')
    q = "SELECT * FROM users WHERE users.id IN (#{user_friends}) AND users.id NOT IN (
            SELECT page_invites.invitee_id FROM page_invites
            WHERE page_invites.page_id = #{current_page.id}
            AND page_invites.inviter_id = #{current_user.id}
          ) AND users.id <> #{current_user.id}"
    User.find_by_sql(q)
  end

  def self.page_inviter(inviter_id)
    self.find_by_id(inviter_id)
  end

  def have_asked_a_question?
    return true if self.profile_progress.asked_question
    return false
  end

  def have_upvoted_a_content?
    upvoted_content = self.question_votes + self.answer_votes
    return true if upvoted_content.present?
    return false
  end

  def have_answered_a_question?
    return true if self.replies.present?
    return false
  end

  def have_followed_someone?
    return true if self.followed_users.present?
    return false
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
