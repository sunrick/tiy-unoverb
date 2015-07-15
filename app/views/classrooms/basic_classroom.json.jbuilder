json.(@classroom, :id, :name, :description, :avatar)
json.language @language.name
json.num_teachers @teachers.count
json.num_students @students.count
json.visibility_type "basic"