json.array!(@comments) do |comment|
  json.extract! comment, :id, :user_id, :activity_id, :content, :created_at
end