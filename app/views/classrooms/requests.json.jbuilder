json.array! @requests do |request|
  json.request_id request.id
  json.message request.message
  json.user do
    json.username request.user.username
    json.first_name request.user.first_name
    json.last_name request.user.last_name
    json.email request.user.email
    json.avatar request.user.avatar
  end
end