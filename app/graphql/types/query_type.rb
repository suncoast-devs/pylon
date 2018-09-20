module Types
  class QueryType < Types::BaseObject
    description "The query root of the Pylon schema"

    field :cohort, CohortType, null: true do
      description "Find a cohort by ID"
      argument :id, ID, required: true
    end

    def cohort(id:)
      Cohort.find(id)
    end
  end
end
