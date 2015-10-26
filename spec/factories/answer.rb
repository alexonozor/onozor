FactoryGirl.define do
  factory :answer, class: Answer do
    body Faker::Lorem.paragraph 
    question
    user
    accepted 1 
    body_plain Faker::Lorem.paragraph
    send_mail [true, false].sample
    user_agent Faker::Name.name
    sequence(:user_ip) { |n| IPAddr.new(n, Socket::AF_INET).to_s }
    referrer Faker::Name.name
  end
end