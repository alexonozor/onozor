class QuestionSerializer < ActiveModel::Serializer
  require 'feed_serializer'
  include Rails.application.routes.url_helpers
  attributes :id, :name, :slug, :body, :created_at, :updated_at, :answers_count, :comments_count, :views,
             :question_link, :comments, :answers, :favourited

  def comments_count
    object.comments.count
  end

  def favourited
    object.favourited?(current_user)
  end

  belongs_to :user, key: :author
  has_many :comments

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
