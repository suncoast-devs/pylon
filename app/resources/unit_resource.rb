class UnitResource < ApplicationResource
  attribute :program_id, :integer
  attribute :cohort_id, :integer

  belongs_to :program
  belongs_to :cohort
end
