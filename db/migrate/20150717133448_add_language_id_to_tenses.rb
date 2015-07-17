class AddLanguageIdToTenses < ActiveRecord::Migration
  def change
    add_column :tenses, :language_id, :integer
  end
end
