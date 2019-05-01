class StudentEnrollmentResource < ApplicationResource
  attribute :unit_id, :integer
  attribute :person_id, :integer

  belongs_to :unit
  belongs_to :person
end
