class Answer < ActiveRecord::Base
  #association
  belongs_to :question, :counter_cache => true
  belongs_to :user
  has_many :answer_votes
  has_many :comments, :as => :commentable, :dependent => :destroy

  #validation
  validates_uniqueness_of :body, { scope: :question_id }
  validates_presence_of :body, :question_id, :user_id
  has_many :comments, :as => :commentable, :dependent => :destroy
  default_scope { order("created_at ASC") }
  # after_validation :update_profile_progress

  def update_profile_progress
      ProfileProgress.update_profile_for_answer_question(self.user) unless self.user.have_answered_a_question?
  end




  def self.by_votes
    select('answers.*, coalesce(value, 0) as votes').
    joins('left join answer_votes on answer_id=answers.id').
    order('votes desc')
  end

  def votes
    read_attribute(:votes) || answer_votes.sum(:value)
  end

  def answer_voters
    query = "SELECT  users.slug, users.first_name, users.last_name, users.email, users.avatar, answer_votes.* as vote  
      FROM users INNER JOIN answer_votes ON users.id = answer_votes.user_id WHERE answer_votes.answer_id  = #{self.id}"
      User.find_by_sql(query)
  end

  def request=(request)
    self.user_ip    = request.remote_ip
    self.user_agent = request.env['HTTP_USER_AGENT']
    self.referrer   = request.env['HTTP_REFERER']
  end
end
