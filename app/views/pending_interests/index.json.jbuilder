json.array!(@pending_interests) do |pending|
  json.extract! pending, :id, :user_id, :name, :created_at
end