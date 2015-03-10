json.array!(@interest_categories) do |category|
  json.extract! category, :id, :name
end
