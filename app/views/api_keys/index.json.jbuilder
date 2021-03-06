json.array!(@api_keys) do |api_key|
  json.extract! api_key, :id, :access_token, :user_id, :expires_at
  json.url api_key_url(api_key, format: :json)
end
