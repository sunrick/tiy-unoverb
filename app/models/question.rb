class Question < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :conjugation
  has_many :solutions
end
