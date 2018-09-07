class QuestionSerializer < ActiveModel::Serializer
  require 'feed_serializer'
  include Rails.application.routes.url_helpers
  attributes :id, :name, :slug, :body, :created_at, :updated_at, :answers_count, :comments_count, :views,
             :question_link, :comments, :answers, :favourited, :vote_count, :vote

  def comments_count
    object.comments.count
  end

  def vote_count
    object.votes
  end

  def favourited
    object.favourited?(current_user)
  end

  def vote
    vote = QuestionVote.find_by(question_id: object.id, user_id: current_user)
    # binding.pry
    if vote.present? && vote.value === 1
      { currentUserHasUpvote: true, currentUserHasDownVote: false, voteValue: vote.value }
    elsif vote.present? && vote.value === -1
      { currentUserHasUpvote: false, currentUserHasDownVote: true, voteValue: vote.value }
     else
      { currentUserHasUpvote: false, currentUserHasDownVote: false, voteValue: 0 }
    end
  end



  belongs_to :user, key: :author
  has_many :comments
  belongs_to :category

  def question_link
    api_v1_question_path(object.slug)
  end

  def comments
    api_v1_question_comments_path(object.slug)
  end

  def answers
    api_v1_question_answers_path(object.slug)
  end
end
