class User < ActiveRecord::Base
  before_save { self.username = username.downcase }
  validates :username, presence: true, length: { maximum: 50 },
		       uniqueness: { case_sensitive: false }
end
