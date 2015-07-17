json.array! @results do |result|

  question = result[:question]
  verb = result[:verb]
  tense = result[:tense]
  form = result[:form]
  conjugation = result[:conjugation]

  json.id question.id
  json.form form.form
  json.verb verb.verb
  json.combined_tense_english tense.combined_tense_english
  json.conjugation conjugation.conjugation
end