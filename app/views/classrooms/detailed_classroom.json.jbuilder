json.(@classroom, :id, :name, :description)
json.language @language.name
json.teachers do
  json.array! @teachers do |teacher|
    json.id teacher.id
    json.username teacher.username
    json.first_name teacher.first_name
    json.last_name teacher.last_name
    json.avatar teacher.avatar
    json.role "teacher"
  end
end
json.students do
  json.array! @students do |student|
    json.id student.id
    json.username student.username
    json.first_name student.first_name
    json.last_name student.last_name
    json.avatar student.avatar
    json.role "student"
  end
end