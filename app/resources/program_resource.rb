class ProgramResource < ApplicationResource
  attribute :title, :string
  attribute :identifier, :string

  has_many :units
end
