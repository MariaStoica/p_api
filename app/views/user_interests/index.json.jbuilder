json.array!(@user_interests) do |user_interest|
  json.extract! user_interest, :id, :user_id, :interest_id
  json.url user_interest_url(user_interest, format: :json)
end
