class Exercise < ActiveRecord::Base
  has_many :questions
  belongs_to :classroom
end
