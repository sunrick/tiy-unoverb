json.verbs do
  json.array! @verbs do |verb|
    json.(verb, :verb)
  end
end