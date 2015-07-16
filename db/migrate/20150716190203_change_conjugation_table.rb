class ChangeConjugationTable < ActiveRecord::Migration
  def change
    rename_column :conjugations, :verb_english, :example_english
    remove_column :conjugations, :combined_tense
    remove_column :conjugations, :combined_tense_english
    remove_column :conjugations, :mood
    remove_column :conjugations, :mood_english
    remove_column :conjugations, :tense
    remove_column :conjugations, :tense_english
    add_column :conjugations, :tense_id, :integer
  end
end
