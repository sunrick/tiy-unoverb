class CreateConjugations < ActiveRecord::Migration
  def change
    create_table :conjugations do |t|
      t.string :combined_tense
      t.string :combined_tense_english
      t.string :mood
      t.string :mood_english
      t.string :tense
      t.string :tense_english
      t.string :verb_english
      t.string :gerund
      t.string :gerund_english
      t.string :pastparticiple
      t.string :pastparticiple_english
      t.timestamps null: false
    end
  end
end
