class Conjugation < ActiveRecord::Base
  belongs_to :verb
  belongs_to :tense
  belongs_to :form
  has_many :questions
  has_many :solutions, through: :questions
end
