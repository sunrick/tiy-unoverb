class CreateExerciseVerbs < ActiveRecord::Migration
  def change
    create_table :exercise_verbs do |t|
      t.integer :exercise_id
      t.integer :conjugation_id
      t.timestamps null: false
    end
  end
end
