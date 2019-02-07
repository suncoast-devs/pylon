class Person < ApplicationRecord
  has_many :emails, dependent: :destroy
  has_many :phone_numbers, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :links, dependent: :destroy, as: :linkable
  has_one  :student_profile, dependent: :destroy
  has_many :student_enrollments, dependent: :destroy
  has_many :programs, through: :student_enrollments
  has_many :cohorts, through: :student_enrollments
end
