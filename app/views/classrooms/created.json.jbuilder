json.(@classroom, :id, :name, :description, :code)
json.(@language, :name)
json.user do
  json.username @user.username
  json.role @role.role
end