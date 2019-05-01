class CohortResource < ApplicationResource
  attribute :name, :string
  attribute :description, :string

  has_many :units
  many_to_many :people
end
