class CategorySerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :description, :created_at, :updated_at, :permalink, :slug, :image, :links, :subscribers_count, :question_count, :subscribe
  def links
    {
        questions: get_questions_category_path(object.slug)
    }
  end

  def subscribe
    return object.subscribe?(current_user) if current_user.present?
    return false
  end
end
