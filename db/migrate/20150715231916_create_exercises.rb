class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.integer :classroom_id
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
