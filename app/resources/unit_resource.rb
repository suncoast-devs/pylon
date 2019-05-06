class UnitResource < ApplicationResource
  attribute :program_id, :integer
  attribute :title, :string

  belongs_to :program
end
