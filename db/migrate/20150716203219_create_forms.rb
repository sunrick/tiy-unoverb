class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.integer :language_id
      t.string :form
      t.timestamps null: false
    end
  end
end
