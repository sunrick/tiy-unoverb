class Request < ActiveRecord::Base
  belongs_to :user
  belongs_to :classroom

  validates :user_id, presence: true
  validates :classroom_id, presence: true
  validates :role, presence: true
end
