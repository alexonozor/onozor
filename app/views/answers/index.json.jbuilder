json.array!(@answers) do |answer|
  json.extract! answer, :id, :body, :question_id, :user_id, :accepted, :body_plain, :send_mail
  json.url answer_url(answer, format: :json)
end
