class UsersSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :slug, :email, :avatar, :bio, :following
  def full_name
    object.fullname
  end

  def following
    if current_user
     object.following?(current_user)
    else
      return false
    end
  end
end
