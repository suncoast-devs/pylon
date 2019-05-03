class CohortResource < ApplicationResource
  attribute :name, :string
  attribute :description, :string
  attribute :start_date, :date
  attribute :end_date, :date

  has_many :units
  has_many :cohort_dates
  many_to_many :attendance_records
  many_to_many :people
end
