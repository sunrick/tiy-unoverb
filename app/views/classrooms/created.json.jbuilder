json.(@classroom, :id, :name, :description, :code)
json.language @language.name
json.user do
  json.username @user.username
  json.role @role.role
end