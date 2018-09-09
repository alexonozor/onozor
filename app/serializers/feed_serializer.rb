class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :slug, :email, :avatar, :bio
  def full_name
    object.fullname
  end
end


class FeedSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  # embed :ids, include: true
  attributes :id, :name, :slug, :body, :created_at, :links, :answers_count, :comments_count, :views, :favourited, :vote_count, :vote, :sharePost
  belongs_to :category
  belongs_to :user, key: :author, serializer: AuthorSerializer

  def vote
    if  current_user.present?
    vote = QuestionVote.find_by(question_id: object.id, user_id: current_user.id)
      # binding.pry
      if vote.present? && vote.value === 1
        { currentUserHasUpvote: true, currentUserHasDownVote: false, voteValue: vote.value }
      elsif vote.present? && vote.value === -1
        { currentUserHasUpvote: false, currentUserHasDownVote: true, voteValue: vote.value }
      else
        { currentUserHasUpvote: false, currentUserHasDownVote: false, voteValue: 0 }
      end
    else
      { currentUserHasUpvote: false, currentUserHasDownVote: false, voteValue: 0 }
    end
  end

  def vote_count
    object.votes
  end

  def favourited
    return object.favourited?(current_user) if current_user.present?
    return false
  end

  def sharePost
    false
  end



  def links
    {self: question_path(object.slug)}
  end
end







