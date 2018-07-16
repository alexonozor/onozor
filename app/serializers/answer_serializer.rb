class AnswerSerializer < ActiveModel::Serializer
  require_relative 'feed_serializer'
  require_relative 'comment_serializer'

  attributes :id, :body, :created_at, :updated_at, :send_mail
  belongs_to :user, key: :author, serializer: AuthorSerializer

  has_many :comments

  class CommentSerializer < ActiveModel::Serializer
    attributes :id, :body, :commentable_type, :commentable_id, :author
    belongs_to :user, key: :author, serializer: AuthorSerializer
    def author
      {
          id: object.user.id,
          full_name: object.user.fullname,
          slug: object.user.slug,
          avatar: object.user.avatar

      }
    end
  end
end
