class Role < ActiveRecord::Base
  belongs_to :classroom, counter_cache: true
  belongs_to :user
end
