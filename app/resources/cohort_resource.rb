class CohortResource < ApplicationResource
  attribute :name, :string
  attribute :description, :string
  attribute :start_date, :date
  attribute :end_date, :date
  attribute :program_id, :integer

  belongs_to :program
  many_to_many :units

  has_many :cohort_dates
  has_many :student_enrollments

  many_to_many :people
end
