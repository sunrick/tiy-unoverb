class AddPasswordToClassrooms < ActiveRecord::Migration
  def change
    add_column :classrooms, :password, :string
  end
end
