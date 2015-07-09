class AddVerbIdToConjugations < ActiveRecord::Migration
  def change
    add_column :conjugations, :verb_id, :integer
  end
end
