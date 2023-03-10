class Student < ApplicationRecord
    validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 18 }
    validates :instructor_id, presence: true

    belongs_to :instructor
end
