module Mutations
  class UpdateCohort < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :input, Types::CohortInput, required: true

    field :cohort, Types::Cohort, null: true
    field :errors, [String], null: false

    def resolve(id:, input:)
      cohort = Cohort.find(id)
      if cohort.update(input.to_h)
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
