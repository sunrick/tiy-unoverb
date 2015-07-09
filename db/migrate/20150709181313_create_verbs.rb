class CreateVerbs < ActiveRecord::Migration
  def change
    create_table :verbs do |t|
      t.string :verb
      t.string :verb_english
      t.integer :language_id
      t.timestamps null: false
    end
  end
end
