json.array!(@goingtoactivities) do |goingtoactivity|
  json.extract! goingtoactivity, :id, :user_id, :activity_id
  json.url goingtoactivity_url(goingtoactivity, format: :json)
end
