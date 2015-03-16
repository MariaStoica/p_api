json.array!(@activities) do |activity|
  json.extract! activity, :id, :name, :user_id, :location, :time, :nrofpeopleinvited
  json.url activity_url(activity, format: :json)
end
