json.game do
  json.id @result[:game].id
  json.user do
    json.(@result[:user], :username, :first_name, :last_name, :avatar)
  end
  json.score do
    json.attempts @result[:attempts]
    json.correct @result[:correct]
    json.wrong @result[:wrong]
    json.accuracy @result[:accuracy]
    json.top_time @result[:top_time]
    json.slowest_time @result[:slowest_time]
    json.avg_time @result[:avg_time]
  end
end
json.questions do
  json.array! @result[:solution_scores] do |solution_score|
    json.question_id solution_score[:question].id
    json.conjugation solution_score[:conjugation].conjugation
    json.verb solution_score[:verb].verb
    json.form solution_score[:form].form
    json.tense solution_score[:tense].combined_tense_english
    json.correct solution_score[:correct]
    json.time solution_score[:time]
  end
end