class Cohort < ApplicationRecord
  has_many :student_profiles, dependent: :nullify
  has_many :people, through: :student_profiles

  validates :name, presence: true
end
