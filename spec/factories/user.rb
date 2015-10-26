
FactoryGirl.define do
  user_name = Faker::Internet.user_name

  factory :user, class: User do
    sequence(:email) { |n| "#{user_name}_#{n}@gmail.com" }
    sequence(:username) { |n| "#{user_name}_#{n}" }
    password  'password'
    password_confirmation 'password'
  end
end