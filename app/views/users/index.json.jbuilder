json.array!(@users) do |user|
  json.extract! user, :id, :first_name, :last_name, :phone_number, :password_digest, :avatar, :description
  json.url user_url(user, format: :json)
end
