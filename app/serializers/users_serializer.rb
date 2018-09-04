class UsersSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :slug, :email, :avatar, :bio, :following, :cover_photo
  def full_name
    object.fullname
  end

  def following
    if current_user && current_user.following?(object)
      return true
    else
      return false
    end
  end
end
