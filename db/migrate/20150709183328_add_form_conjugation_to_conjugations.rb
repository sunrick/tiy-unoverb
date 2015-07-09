class AddFormConjugationToConjugations < ActiveRecord::Migration
  def change
    add_column :conjugations, :form, :string
    add_column :conjugations, :conjugation, :string
  end
end
