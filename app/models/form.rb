class Form < ActiveRecord::Base
  belongs_to :language
  has_many :conjugations
end
