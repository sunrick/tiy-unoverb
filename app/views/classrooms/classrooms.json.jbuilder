json.array! @classrooms do |classroom|
  json.(classroom, :id, :name, :description)
  json.language @language.name
  json.num_participants classroom.roles_count
end