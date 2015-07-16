class RemoveVerbId < ActiveRecord::Migration
  def change
    remove_column :tenses, :verb_id
  end
end
