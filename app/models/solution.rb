class Solution < ActiveRecord::Base
  belongs_to :game
  belongs_to :question
  
  validates :time, numericality: { only_integer: true }
  validates :guess, presence: true
end
