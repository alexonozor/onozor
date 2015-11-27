class Answer < ActiveRecord::Base
  #association
  belongs_to :question, :counter_cache => true
  belongs_to :user
  has_many :answer_votes
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :activities, :foreign_key => 'receiver_id'
  has_paper_trail

  #validation
  validates_uniqueness_of :body, { scope: :question_id }
  validates_presence_of :body, :question_id, :user_id
  has_many :comments, :as => :commentable, :dependent => :destroy

  after_create :notify_user

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

  def replyer
    question.user
  end


  def notify_user
   (people_who_replied_on_a_question).each do |user|
      notification_params = Activity.create!(
          :sender_id => self.user.id,
          :receiver_id => user.id,
          :notifier_id => self.id,
          :notifier_type => self.class.name
      )
   end
  end

  def people_who_replied_on_a_question
    Answer.where(question_id: question.id).map(&:user).uniq
  end
end