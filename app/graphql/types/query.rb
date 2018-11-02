module Types
  class Query < Types::BaseObject
    description "The query root of the Pylon schema"

    field :cohort, Types::Cohort, null: true do
      description "Find a cohort by ID"
      argument :id, ID, required: true
      guard -> (obj, args, ctx) { ctx[:current_user].present? }
      mask -> (ctx) { ctx[:current_user].present? }
    end

    def cohort(id:)
      Cohort.find(id)
    end

    field :cohorts, [Types::Cohort], null: false do
      description "List all cohorts"
      guard -> (obj, args, ctx) { ctx[:current_user].present? }
      mask -> (ctx) { ctx[:current_user].present? }
    end

    def cohorts
      Cohort.all
    end
  end
end
