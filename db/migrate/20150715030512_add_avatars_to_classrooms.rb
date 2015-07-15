class AddAvatarsToClassrooms < ActiveRecord::Migration
    def up
    add_attachment :classrooms, :avatar
  end

  def down
    remove_attachment :classrooms, :avatar
  end
end
