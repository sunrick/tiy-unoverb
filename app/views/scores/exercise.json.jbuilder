json.array! @results do |result|
  json.question do
    json.question_id result[:question].id
    json.form result[:form].form
    json.tense result[:tense].combined_tense_english
    json.verb result[:verb].verb
    json.conjugation result[:conjugation].conjugation
  end
  json.score_data do
    json.attempts result[:attempts]
    json.correct result[:correct]
    json.wrong result[:wrong]
    json.accuracy result[:accuracy]
  end
  json.common_mistakes do
    json.array! result[:common_mistakes] do |common_mistake|
      json.mistake common_mistake[0]
      json.count common_mistake[1]
    end
  end
end