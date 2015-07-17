class Language < ActiveRecord::Base
  has_many :classrooms
  has_many :forms
end
