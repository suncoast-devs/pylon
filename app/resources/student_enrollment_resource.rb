class StudentEnrollmentResource < ApplicationResource
  attribute :cohort_id, :integer
  attribute :person_id, :integer
  attribute :units, :array

  belongs_to :cohort
  belongs_to :person
end
