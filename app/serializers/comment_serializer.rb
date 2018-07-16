require_relative 'feed_serializer'
class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :commentable_type, :commentable_id
  belongs_to :user, key: :author, serializer: AuthorSerializer
end
