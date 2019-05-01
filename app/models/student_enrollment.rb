class StudentEnrollment < ApplicationRecord
  belongs_to :unit
  belongs_to :person
end
