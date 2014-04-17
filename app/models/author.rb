class Author < ActiveRecord::Base
    has_many :pictures, dependent: :destroy
    validates :name, presence: true,
                     length: { minimum: 4 }
end
