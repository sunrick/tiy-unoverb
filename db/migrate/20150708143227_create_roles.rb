class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :classroom_id
      t.integer :user_id
      t.boolean :teacher
      t.timestamps null: false
    end
  end
end
