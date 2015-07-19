json.array! @results do |result|

  question = result[:question]
  verb = result[:verb]
  tense = result[:tense]
  form = result[:form]
  conjugation = result[:conjugation]

  json.question_id question.id
  json.form form.form
  json.verb verb.verb
  json.verb_english verb.verb_english
  json.combined_tense_english tense.combined_tense_english
  json.example_english conjugation.example_english
  json.answer conjugation.conjugation
end