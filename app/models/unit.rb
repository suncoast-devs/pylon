class Unit < ApplicationRecord
  belongs_to :cohort
  belongs_to :program

  has_many :student_enrollments
  has_many :people, through: :student_enrollments
end
