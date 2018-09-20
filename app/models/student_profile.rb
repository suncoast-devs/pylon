class StudentProfile < ApplicationRecord
  belongs_to :person
  belongs_to :cohort
  belongs_to :program
end
