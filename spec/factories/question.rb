FactoryGirl.define do
  factory :question, class: Question do
    sequence(:name) {|n| "question_#{n}"}
    sequence(:body) { |n|  "#{n} #{Faker::Lorem.paragraph}" }
    user
    views Faker::Number.number(3)
    answers_count Faker::Number.number(3)
    permalink Faker::Internet.url
    # why question model holds answer_id ? 
    # One question can have multiple answers so technically answer model should hold question_id not the reverse.
    # answer
    sequence(:slug) { |s| "#{Faker::Internet.slug}_#{s}" }
    comments_count Faker::Number.number(3)
  end
end