json.array!(@alltags) do |alltag|
  json.extract! alltag, :id, :name, :description, :user_id, :question_id
  json.url alltag_url(alltag, format: :json)
end
