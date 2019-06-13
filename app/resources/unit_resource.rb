class UnitResource < ApplicationResource
  attribute :title, :string

  belongs_to :program
end
