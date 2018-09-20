module Types
  class MutationType < Types::BaseObject
    field :create_cohort, mutation: Mutations::CreateCohort
  end
end
