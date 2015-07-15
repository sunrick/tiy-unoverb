json.array! @classrooms do |classroom|
  json.(classroom, :id, :name, :description, :avatar)
  json.language @language.name
  json.num_participants classroom.roles_count
end