class AnswerSerializer < ActiveModel::Serializer
  require_relative 'feed_serializer'
  attributes :id, :body, :question_id, :created_at, :updated_at, :send_mail, :comments_count, :vote_count, :vote
  belongs_to :user, key: :author
  def comments_count
    object.comments.count
  end

  def vote_count
    object.votes
  end
  
  def vote
    vote = AnswerVote.find_by(answer_id: object.id, user_id: current_user.id)
    if vote.present? && vote.value === 1
      { currentUserHasUpvote: true, currentUserHasDownVote: false, voteValue: vote.value }
    elsif vote.present? && vote.value === -1
      { currentUserHasUpvote: false, currentUserHasDownVote: true, voteValue: vote.value }
     else
      { currentUserHasUpvote: false, currentUserHasDownVote: false, voteValue: 0 }
    end
  end
end
