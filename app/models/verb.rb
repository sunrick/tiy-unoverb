class Verb < ActiveRecord::Base
  belongs_to :language
  has_many :conjugations
  has_many :tenses, through: :conjugations
end
