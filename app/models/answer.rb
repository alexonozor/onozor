class Answer < ActiveRecord::Base
  #association
  belongs_to :question, :counter_cache => true
  belongs_to :user
  has_many :answer_votes
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :activities,  as: :notifier, :foreign_key => 'receiver_id'

  #validation
  validates_uniqueness_of :body, { scope: :question_id }
  validates_presence_of :body, :question_id, :user_id
  has_many :comments, :as => :commentable, :dependent => :destroy

  after_validation :update_profile_progress

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

  def request=(request)
    self.user_ip    = request.remote_ip
    self.user_agent = request.env['HTTP_USER_AGENT']
    self.referrer   = request.env['HTTP_REFERER']
  end
end
