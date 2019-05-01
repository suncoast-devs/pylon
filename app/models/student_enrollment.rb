class StudentEnrollment < ApplicationRecord
  belongs_to :cohort
  belongs_to :unit
  belongs_to :person
end
