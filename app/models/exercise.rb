class Exercise < ActiveRecord::Base
  has_many :questions
  belongs_to :classroom
  validates :name, presence: true, uniqueness: true
end
