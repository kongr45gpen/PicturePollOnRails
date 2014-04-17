class Picture < ActiveRecord::Base
  belongs_to :author
  validates :filename, presence: true
end
