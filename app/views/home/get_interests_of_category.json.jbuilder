json.array!(@interests) do |interest|
  json.extract! interest, :id, :name, :category_id
end
