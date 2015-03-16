json.activities_i_created!(@activities_i_created) do |activity|
  json.extract! activity, :id, :name, :location, :time, :nrofpeopleinvited
end

json.activities_im_going_to!(@activities_im_going_to) do |activity|
  json.extract! activity, :id, :name, :user_id, :location, :time, :nrofpeopleinvited
end