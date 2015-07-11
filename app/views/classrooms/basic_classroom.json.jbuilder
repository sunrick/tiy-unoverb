json.(@classroom, :id, :name, :description)
json.language @language.name
json.teachers @teachers.count
json.students @students.count