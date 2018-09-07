# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Question.update_all(questionable_type: "Random")
#
# Category.destroy_all
category_list = [
    [ "Technology", "http://res.cloudinary.com/sportbay-co/image/upload/v1443569929/main-thumb-t-2177-200-JiR07D1TQSfeQzRvWXomVaY4Poj2f8Yb_obscwy.jpg" ],
    [ "Science", "http://res.cloudinary.com/sportbay-co/image/upload/v1443569928/main-thumb-t-931-200-c8WCPwZ9qPsh5zLGQ5wHh1ddxtc9Cch7_yquqe7.webp" ],
    [ "Books", "http://res.cloudinary.com/sportbay-co/image/upload/v1443569929/main-thumb-t-1056-200-hPoilc51jNiGKb8dbh4plI8jOw6MJ7pG_ygpjzb.jpg" ],
    [ "Business", "http://res.cloudinary.com/sportbay-co/image/upload/v1443569928/main-thumb-t-858-200-VnZbEVtOIGkEHXlnYId9slumV59IPgkA_otxjs3.webp" ],
    [ "Movies", "http://res.cloudinary.com/sportbay-co/image/upload/v1443569928/main-thumb-t-843-200-W7FzODceTO2aQmp8D7E4rKZ8YgSv21eR_gojgpl.jpg" ],
    [ "Health", "http://res.cloudinary.com/sportbay-co/image/upload/v1443569929/main-thumb-t-1140-200-24q3tiv4WhPssc5TGwf0mvCM5aiqGVXW_h3tapp.jpg" ],
    [ "Visiting and Travel", "http://res.cloudinary.com/sportbay-co/image/upload/v1443569928/main-thumb-t-828-200-tDJdGH6ngba9XOtHP0p3blrN9fsNtsFG_tums4k.jpg" ],
    [ "Music", "http://res.cloudinary.com/sportbay-co/image/upload/v1443569928/main-thumb-t-801-200-Sf8h894FXbQZQit0TeqDrrqS6xw6dwCQ_desgsn.jpg" ],
    [ "Education", "http://res.cloudinary.com/sportbay-co/image/upload/v1443569928/main-thumb-t-996-200-bfZBQjeEenKKl8fcNY4tVv0FyArtB0Mb_rffoey.jpg" ],
    [ "Food", "http://res.cloudinary.com/sportbay-co/image/upload/v1443569929/main-thumb-t-1026-200-Qz7G3K2Z3xGKJyYywUDAo9smWLTuFQxT_nbizlh.webp" ],
    [ "Psychology", "http://res.cloudinary.com/sportbay-co/image/upload/v1443569929/main-thumb-t-1913-200-B8JrwaVauFzsaTSqXDqoWLCXzQb2mTE9_ajpijd.jpg" ],
    [ "Design", "http://res.cloudinary.com/sportbay-co/image/upload/v1443569928/main-thumb-t-897-200-OFeNluKHo6ajfqd3gvlyOn0qCbZ4cNpb_v58ouy.jpg" ],
    [ "History", "http://res.cloudinary.com/sportbay-co/image/upload/v1443569928/main-thumb-t-930-200-cbbsbwijdhpyzlpipejvqpiijhhoaday_n8pio3.jpg" ],
    [ "Economics", "http://res.cloudinary.com/sportbay-co/image/upload/v1443570679/main-thumb-t-1575-200-A6ModxJzIbs4YcwW010Fkp6FNJOUxcbC_rin811.webp"],
    [ "Cooking", "http://res.cloudinary.com/sportbay-co/image/upload/v1443570679/main-thumb-t-877-200-e7jKHEQr0HExAIA9rlsyHlV6HJyRruEo_lhgvxj.webp" ],
    [ "Writing", "http://res.cloudinary.com/sportbay-co/image/upload/v1443570678/main-thumb-t-2062-200-cuGKoaTVa5xcTTICGaLWKWmk8i9Bqhrp_pinppg.webp" ],
    [ "Sports", "http://res.cloudinary.com/sportbay-co/image/upload/v1443570679/main-thumb-t-795-200-QA3tENUgceTmZxY6g8N1uyY1XkgoLB3g_qqv8fq.webp" ]
    # [ "Photography", "" ],
    # [ "Philosophy", "" ],
    # [ "Marketing", "" ],
    # [ "Finance", "" ],
    # [ "Mathematics", "" ],
    # [ "Fashion and Style", "" ],
    # [ "Literature", "" ],
    # [ "Politics", "" ],
    # [ "Television Series", "" ],
    # [ "Fine Art", "" ],
    # [ "Journalism", "" ],
    # [ "Current Events in Technology", "" ],
    # [ "Startups", "" ],
    # [ "Silicon Valley", "" ],
    # [ "Mobile Phones", "" ],
    # [ "Computer Science", "" ],
    # [ "Research", "" ],
    # [ "Writers and Authors", "" ],
    # [ "Publishing", "" ],
    # [ "Literary Fiction", "" ],
    # [ "Fiction", "" ],
    # [ "Novels", "" ],
    # [ "Book Recommendations", "" ],
    # [ "Current Events in Business", "" ],
    # [ "Investing", "" ],
    # [ "Venture Capital", "" ],
    # [ "Small Businesses", "" ],
    # [ "Money", "" ],
    # [ "Lean Startups", "" ],
    # [ "Bollywood", "" ],
    # [ "Entertainment", "" ],
    # [ "Television", "" ],
    # [ "Actors and Actresses", "" ],
    # [ "Hollywood", "" ],
    # [ "Science Fiction (genre)", "" ],
    # [ "Medicine and Healthcare", "" ],
    # [ "Pharmaceuticals", "" ],
    # [ "Nutrition", "" ],
    # [ "Doctors", "" ],
    # [ "Sleep", "" ],
    # [ "Healthy Eating", "" ],
    # [ "Hotels", "" ],
    # [ "New York City", "" ],
    # [ "Europe", "" ],
    # [ "African", "" ],
    # [ "Tourism", "" ],
    # [ "Airlines", "" ],
    # [ "Musicians", "" ],
]

# category_list.each do |name, image|
#   Category.create!( name: name, image: image )
# end

def update_biography(user)
  user.profile_progress.update(written_bio: true)
  user.progress += 20
  user.save
end

def ask_question(user)
  user.profile_progress.update(asked_question: true)
  user.progress += 20
  user.save
end

def update_followers(user)
  user.profile_progress.update(followed_someone: true)
  user.progress += 20
  user.save
end

def update_answered_question(user)
  user.profile_progress.update(answered_question: true)
  user.progress += 20
  user.save
end

def update_upvoted_question(user)
  user.profile_progress.update!(voted_for_content: true)
  user.progress += 20
  user.save
end


def update_profile(user)
  if user.bio.present?
    update_biography(user)
  end

  if user.questions.present?
    ask_question(user)
  end

  if user.followed_users.present?
    update_followers(user)
  end


 if user.replies.present?
    update_answered_question(user)
  end

 upvoted_content = user.question_votes + user.answer_votes

  if upvoted_content.present?
    update_upvoted_question(user)
  end
end



User.all.each do |user|
  user.create_profile_progress
  update_profile(user)
end
