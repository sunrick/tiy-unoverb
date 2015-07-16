class ChangeExerciseVerbsToQuestions < ActiveRecord::Migration
  def change
    rename_table :exercise_verbs, :questions
  end
end
