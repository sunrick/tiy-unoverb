class Exercise < ActiveRecord::Base
  has_many :questions
  belongs_to :classroom
  has_many :games
  has_many :solutions, through: :games
  validates :name, presence: true, uniqueness: true
end
