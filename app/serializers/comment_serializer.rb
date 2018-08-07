class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :commentable_type, :commentable_id, :user_id, :created_at, :updated_at
  belongs_to :user, foreign_key: :user_id
end
