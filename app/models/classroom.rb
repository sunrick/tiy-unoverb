class Classroom < ActiveRecord::Base
  belongs_to :language
  has_many :exercises
  has_many :roles
  has_many :users, through: :roles

  validates :name, uniqueness: true, presence: true
  validates :code, presence: true

  has_attached_file :avatar, default_url: "https://s3-us-west-2.amazonaws.com/unoverb-prod/default/missing.png"
  validates_attachment_content_type :avatar, content_type: ["image/jpg", "image/jpeg", "image/png"]

end
