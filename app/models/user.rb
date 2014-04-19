class User < ActiveRecord::Base
  before_save { username.downcase! }
  validates :username, presence: true, length: { maximum: 50 },
		       uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  has_secure_password
end
