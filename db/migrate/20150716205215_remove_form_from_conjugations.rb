class RemoveFormFromConjugations < ActiveRecord::Migration
  def change
    remove_column :conjugations, :form
    add_column :conjugations, :form_id, :integer
  end
end
