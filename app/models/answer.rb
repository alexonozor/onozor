class Answer < ActiveRecord::Base
  after_create :send_answer_email

 #association
 belongs_to :question, :counter_cache => true
 belongs_to :user
 has_many :answer_votes
 has_many :comments, :as => :commentable, :dependent => :destroy
 has_paper_trail
 


  #validation
  validates_uniqueness_of :body
  validates_presence_of :body, :question_id, :user_id
  validates_length_of   :body, :within => 25..20048
  has_many :comments, :as => :commentable, :dependent => :destroy

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


  def send_answer_email
     UserMailer.answer_update(self).deliver if self.question.send_mail == true
  end
  #scope


   #schema
 #t.text     "body"
 #t.integer  "question_id"
 #t.integer  "user_id"
 #t.integer  "accepted"
 #t.text     "body_plain"
 #t.boolean  "send_mail",   default: false
 #t.datetime "created_at"
 #t.datetime "updated_at"

end
