class CohortResource < ApplicationResource
  attribute :name, :string
  attribute :description, :string

  many_to_many :people
end
