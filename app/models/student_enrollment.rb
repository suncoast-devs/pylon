class StudentEnrollment < ApplicationRecord
  belongs_to :cohort
  belongs_to :program
  belongs_to :person
end
