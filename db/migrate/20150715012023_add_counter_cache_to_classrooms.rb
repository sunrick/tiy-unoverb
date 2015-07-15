class AddCounterCacheToClassrooms < ActiveRecord::Migration
  def up
    add_column :classrooms, :roles_count, :integer, default: 0
    Classroom.reset_column_information
    Classroom.all.each do |c|
      c.update_attribute :roles_count, c.roles.length
    end
  end
  def down 
    remove_column :classrooms, :roles_count
  end
end
