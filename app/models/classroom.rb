class Classroom < ActiveRecord::Base
  belongs_to :language
  has_many :exercises
  has_many :roles
  has_many :users, through: :roles

  validates :name, uniqueness: true, presence: true
  validates :code, presence: true
end
