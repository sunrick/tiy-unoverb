class Tense < ActiveRecord::Base
  has_many :conjugations
  has_many :verbs, through: :conjugations
end
