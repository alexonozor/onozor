class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :slug, :email, :avatar
  def full_name
    object.fullname
  end
  has_many :comments
  has_many :answers
end


