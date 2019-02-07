class Program < ApplicationRecord
  has_many :student_enrollments, dependent: :nullify
  has_many :people, through: :student_enrollments
end
