# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Language.create(name: "spanish")


def importer_thing
  csv_file = "spanish_database.csv"

  @forms = ["yo","tu","el/ella/usted","nosotros","vosotros","ellos_ellas_ustedes"]
  @language = Language.find_by(name: "spanish")

  csv = []
  CSV.foreach(csv_file, headers: true, encoding: "bom|utf-8") do |row|

    verb_hash = {
      verb:             row['infinitive'],
      verb_english:     row['infinitive_english'],
    }

    tense_hash {
      combined_tense:         row['mood'] + " " + row['tense'],
      combined_tense_english: row['mood_english'] + " " + row['tense_english'],
      mood:                   row['mood'],
      mood_english:           row['mood_english'],
      tense:                  row['tense'],
      tense_english:          row['tense_english'],
      verb_english:           row['verb_english'],
      gerund:                 row['gerund'],
      gerund_english:         row['gerund_english'],
      pastparticiple:         row['pastparticiple'],
      pastparticiple_english: row['pastparticiple_english']
    }

    verb_hash = verb_hash.merge({ language: @language})
    @verb = Verb.create(verb_hash)

    prep_count = 0
    form_count = 7
    until form_count == 12
      conjugation = {
        form: @forms[prep_count],
        conjugation: row[form_count]
      }

      combo = tense_hash.merge(conjugation)
      combo = combo.merge({verb: @verb})
      Conjugation.create(combo)

      form_count += 1
      prep_count += 1
    end
  end
  csv
end
