class Classroom < ActiveRecord::Base
  belongs_to :language
  has_many :exercises
  has_many :users, through: :roles
end