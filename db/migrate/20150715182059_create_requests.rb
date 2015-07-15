class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :user_id
      t.integer :classroom_id
      t.string :message
      t.timestamps null: false
    end
  end
end
