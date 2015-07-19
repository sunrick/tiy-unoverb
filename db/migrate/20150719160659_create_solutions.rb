class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.integer :game_id
      t.string :guess
      t.boolean :correct
      t.integer :time
      t.integer :question_id
      t.timestamps null: false
    end
  end
end
