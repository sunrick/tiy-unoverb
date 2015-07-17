class Language < ActiveRecord::Base
  has_many :classrooms
  has_many :forms
  has_many :tenses
  has_many :verbs
end
