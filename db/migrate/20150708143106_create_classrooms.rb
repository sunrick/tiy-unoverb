class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.string :name
      t.string :description
      t.integer :language_id
      t.timestamps null: false
    end
  end
end
