class Program < ApplicationRecord
  has_many :student_profiles
  has_many :people, through: student_profiles
end
