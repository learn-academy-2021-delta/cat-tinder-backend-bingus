class Cat < ApplicationRecord
    validates :name, :age, :gender, :breed, :enjoys, presence: true
    validates :enjoys, length: {minimum: 10}
end
