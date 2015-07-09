class CreateTenses < ActiveRecord::Migration
  def change
    create_table :tenses do |t|

      t.timestamps null: false
    end
  end
end
