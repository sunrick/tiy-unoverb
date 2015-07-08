class ChangeColumn < ActiveRecord::Migration
  def change
    remove_column :roles, :teacher
    add_column :roles, :role, :string
  end
end
