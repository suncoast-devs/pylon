class ProgramResource < ApplicationResource
  attribute :title, :string
  attribute :identifier, :string

  belongs_to :unit
end
