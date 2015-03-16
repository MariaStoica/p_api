json.array!(@my_feed) do |activity|
  json.extract! activity, :id, :name, :user_id, :location, :time, :nrofpeopleinvited
end