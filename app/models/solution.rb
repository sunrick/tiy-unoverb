class Solution < ActiveRecord::Base
  belongs_to :game
  belongs_to :question
  has_one :exercise, through: :game
  has_one :user, through: :game
  has_one :conjugation, through: :question
  
  validates :time, numericality: { only_integer: true }
  validates :guess, presence: true
end
