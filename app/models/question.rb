class Question < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
 #filters
  acts_as_taggable


  before_validation :set_permalink

  # after_create :send_slack_message if Rails.env.production?
  has_ancestry

 extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

 #association
 belongs_to :page
 belongs_to :user
 belongs_to :category
 has_many   :alltags
 has_many   :answers,                       :dependent => :destroy
 has_many   :favourites,                    :dependent => :destroy
 has_many   :question_votes,                :dependent => :destroy
 has_many   :comments, as:    :commentable, :dependent => :destroy
 belongs_to :accepted_answer, :class_name => "Answer", :foreign_key => :answer_id

 #validation
 validates_presence_of    :name, :user_id #:tag_list
 validates_length_of      :name, :within => 5..2000
 #validates_length_of      :body, :within => 10...20000
 validates_uniqueness_of  :name, :body

  #scope
  default_scope          ->{ order('created_at DESC')}
  scope :latest,         ->{ where("questions.created_at DESC")}
  scope :popular,        ->{ where('questions.views >= ? AND questions.questionable_type <> ?', 10, 'Questions').limit(5)}
  scope :hot,            ->{ where("answers_count > ?", 4)}
  scope :unanswered,     ->{ where("answers_count = ?", 0)}
  scope :answered,       ->{ where("answers_count > ?", 0)}
  scope :page_questions, ->{ where("questionable_type = ?", "question")}

  def self.page_question?(question)
    return true if question.questionable_type ='question' && question.questionable_type != nil
    return false
  end

  def self.active
    a = Time.now - 2.days
    current_date = a.to_s(:db)
    a = "SELECT * FROM questions WHERE id IN (SELECT question_id FROM answers WHERE created_at > '#{current_date}')"
     Question.find_by_sql(a)
  end

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

  def favourited?(user)
    Favourite.find_by_user_id_and_question_id(user.id, self).present?
  end

  def self.search(text)
    if text
      where('name LIKE ?', "%#{text}%")
    else
      []
    end
  end

  def self.similar_question(question)
    sql = "select name, slug from questions where category_id = #{question.category_id} limit 9"
    Question.find_by_sql(sql)
  end


  def send_slack_message
    SLACK_NOTIFIER.ping("<!channel> New Question from #{self.user.username} :
                 #{self.name} <http://www.onozor.com/questions/#{self.slug}|Click here> to answer", http_options: { open_timeout: 5 }) unless Rails.env == 'test'
  end

  def self.news_letter_mailer
    latest_question = self.unanswered
    NewsLetter.deliver_letter(latest_question).deliver
  end





end
