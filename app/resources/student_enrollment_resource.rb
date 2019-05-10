class StudentEnrollmentResource < ApplicationResource
  attribute :cohort_id, :integer
  attribute :person_id, :integer
  attribute :units, :array
  attribute :invitation_code, :string, writable: false

  belongs_to :cohort
  belongs_to :person
end
