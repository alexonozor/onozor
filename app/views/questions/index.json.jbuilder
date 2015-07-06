json.array!(@questions) do |question|
  json.extract! question, :id, :name, :body, :user_id, :views, :answers_count, :permalink, :answer_id, :send_mail
  json.url question_url(question, format: :json)
end
