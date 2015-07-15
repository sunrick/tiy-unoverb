json.array! @teacher_classrooms do |t_classroom|
  json.(t_classroom, :id, :name, :description)
  json.language t_classroom.language.name
  json.role "teacher"
end
json.array! @student_classrooms do |s_classroom|
  json.(s_classroom, :id, :name, :description)
  json.language s_classroom.language.name
  json.role "teacher"
end