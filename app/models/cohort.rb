class Cohort < ApplicationRecord
  has_many :units
  has_many :programs, through: :units

  has_many :student_enrollments, dependent: :nullify
  has_many :people, through: :student_enrollments

  validates :name, presence: true, uniqueness: true
end
