class CategorySerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :description, :created_at, :updated_at, :permalink, :slug, :image, :links
  def links
    {
        questions: get_questions_api_v1_category_path(object.slug)
    }
  end
end
