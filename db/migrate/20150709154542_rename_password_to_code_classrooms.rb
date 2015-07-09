class RenamePasswordToCodeClassrooms < ActiveRecord::Migration
  def change
    rename_column :classrooms, :password, :code
  end
end
