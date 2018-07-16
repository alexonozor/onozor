class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :slug, :email, :avatar
  def full_name
    object.fullname
  end
end


class FeedSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  # embed :ids, include: true
  attributes :id, :name, :slug, :body, :created_at, :links, :answers_count, :comments_count, :views

  belongs_to :user, key: :author, serializer: AuthorSerializer

  def links
    {self: api_v1_question_path(object.slug)}
  end
end







