class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :full_name, :slug, :email, :avatar, :cover_photo, :location, :admin, :last_sign_in_at, 
  :twitter_url, :facebook_url, :personal_website, :bio, :sign_in_count, :created_at, :followers, :followings, :views, :last_requested_at,
  :questions_count, :answers_count, :favourites_count, :following, :has_cover_photo
  def full_name
    object.fullname
  end

  def followers
    object.followers.count
  end

  def followings
    object.followed_users.count
  end

  def questions_count
    object.questions.count
  end

  def answers_count
    object.answers.count
  end

  def favourites_count
    object.favourites.count
  end

  def has_cover_photo
    object.cover_photo?
  end

  def following
    if current_user && current_user.following?(object)
      return true
    else
      return false
    end
  end
end


