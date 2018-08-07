class AnswerSerializer < ActiveModel::Serializer
  require_relative 'feed_serializer'
  attributes :id, :body, :question_id, :created_at, :updated_at, :send_mail, :comments_count
  belongs_to :user, key: :author
  def comments_count
    object.comments.count
  end
end
