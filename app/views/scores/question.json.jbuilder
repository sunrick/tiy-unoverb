json.question do
  json.id @result[:question].id
  json.form @result[:form].form
  json.tense @result[:tense].combined_tense_english
  json.verb @result[:verb].verb
  json.conjugation @result[:conjugation].conjugation
end
json.score_data do
  json.attempts @result[:attempts]
  json.correct @result[:correct]
  json.wrong @result[:wrong]
  json.accuracy @result[:accuracy]
  json.top_time @result[:top_time]
  json.slowest_time @result[:slowest_time]
  json.avg_time @result[:avg_time]
end
json.user_scores do
  json.array! @result[:user_scores].each do |user_score|
    json.user do
      json.id user_score[:user].id
      json.username user_score[:user].username
      json.first_name user_score[:user].first_name
      json.last_name user_score[:user].last_name
      json.avatar user_score[:user].avatar
    end
    json.attempts user_score[:attempts]
    json.correct user_score[:correct]
    json.wrong user_score[:wrong]
    json.accuracy user_score[:accuracy]
    json.top_time user_score[:top_time]
    json.slowest_time user_score[:slowest_time]
    json.avg_time user_score[:avg_time]
    json.common_mistakes do
      json.array! user_score[:common_mistakes] do |common_mistake|
        json.mistake common_mistake[0]
        json.count common_mistake[1]
      end
    end
  end
end


