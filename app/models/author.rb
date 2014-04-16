class Author < ActiveRecord::Base
    has_many :pictures
    validates :name, presence: true,
                     length: { minimum: 4 }
end
