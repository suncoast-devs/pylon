module Mutations
  class CreateCohort < Mutations::BaseMutation
    argument :name, String, required: true
    argument :description, String, required: false

    field :cohort, Types::CohortType, null: true
    field :errors, [String], null: false

    def resolve(name:, description:)
      cohort = Cohort.new(name: name, description: description)
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
