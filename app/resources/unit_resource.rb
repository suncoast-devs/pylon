class UnitResource < ApplicationResource
  attribute :program_id, :integer
  attribute :cohort_id, :integer

  belongs_to :program
  belongs_to :cohort

  has_many :student_enrollments
  many_to_many :people
end
