module Mutations
  class CreateCohort < Mutations::BaseMutation
    argument :cohort, Types::CohortInput, required: true

    field :cohort, Types::Cohort, null: true
    field :errors, [String], null: false

    def resolve(cohort:)
      cohort = Cohort.new(cohort.to_h)
      if cohort.save
        {
          cohort: cohort,
          errors: []
        }
      else
        {
          cohort: nil,
          errors: cohort.errors.full_messages
        }
      end
    end
  end
end
