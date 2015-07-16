class Conjugation < ActiveRecord::Base
  belongs_to :verb
  belongs_to :tense
end
