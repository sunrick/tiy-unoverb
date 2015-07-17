class Tense < ActiveRecord::Base
  has_many :conjugations
  has_many :verbs, through: :conjugations
  belongs_to :language
end
