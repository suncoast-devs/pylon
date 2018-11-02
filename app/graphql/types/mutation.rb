module Types
  class Mutation < Types::BaseObject
    field :create_cohort, mutation: Mutations::CreateCohort do
      guard -> (obj, args, ctx) { ctx[:current_user].is_admin? }
      mask -> (ctx) { ctx[:current_user].present? }
    end
  end
end
