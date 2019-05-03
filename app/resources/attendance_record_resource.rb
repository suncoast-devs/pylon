class AttendanceRecordResource < ApplicationResource
  attribute :id, :integer
  attribute :person_id, :integer
  attribute :cohort_date_id, :integer
  attribute :status, :string
  attribute :note, :string
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false

  belongs_to :person
  belongs_to :cohort_date
end
