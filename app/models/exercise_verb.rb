class ExerciseVerb < ActiveRecord::Base
  belongs_to :exercise
  has_one :conjugation
end
