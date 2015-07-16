json.array! @exercises do |exercise|
  json.(exercise, :id, :name, :description)
end
