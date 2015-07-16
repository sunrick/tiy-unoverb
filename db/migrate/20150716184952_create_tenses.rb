class CreateTenses < ActiveRecord::Migration
  def change
    create_table :tenses do |t|
      t.string :combined_tense
      t.string :combined_tense_english
      t.string :mood
      t.string :mood_english
      t.string :tense
      t.string :tense_english
      t.integer :verb_id

      t.timestamps null: false
    end
  end
end
