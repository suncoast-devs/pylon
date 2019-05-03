class CohortDateResource < ApplicationResource
  attribute :id, :integer, writable: false
  attribute :cohort_id, :integer
  attribute :day, :date
  attribute :description, :string
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false

  belongs_to :cohort
  has_many :attendance_records
end
