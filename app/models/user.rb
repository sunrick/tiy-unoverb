class User < ActiveRecord::Base
  
  validates :password, :access_token, presence: true
  validates :email, uniqueness: true, presence: true
  validates :username, uniqueness: true, presence: true

  has_attached_file :avatar, default_url: "https://s3-us-west-2.amazonaws.com/unoverb-prod/default/missing.png"
  validates_attachment_content_type :avatar, content_type: ["image/jpg", "image/jpeg", "image/png"]

  before_validation :ensure_access_token

  # ASSOCIATIONS
  has_many :roles
  has_many :classrooms, through: :roles
  has_many :requests

  def ensure_access_token
    if self.access_token.blank?
      self.access_token = User.generate_token
    end
  end

  def self.generate_token
    token = SecureRandom.hex
    while User.exists?(access_token: token)
      token = SecureRandom.hex
    end
    token
  end

end
