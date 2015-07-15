class RemoveColumnCodeClassrooms < ActiveRecord::Migration
  def change
    remove_column :classrooms, :code
  end
end
