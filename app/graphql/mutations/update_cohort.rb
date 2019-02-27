module Mutations
  class UpdateCohort < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :cohort, Types::CohortInput, required: true

    field :cohort, Types::Cohort, null: true
    field :errors, [String], null: false

    def resolve(id:, cohort:)
      existing_cohort = Cohort.find(id)
      if existing_cohort.update(cohort.to_h)
        {
          cohort: existing_cohort,
          errors: []
        }
      else
        {
          cohort: nil,
          errors: existing_cohort.errors.full_messages
        }
      end
    end
  end
end
