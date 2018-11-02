module Mutations
  class DestroyCohort < Mutations::BaseMutation
    argument :id, ID, required: true

    field :destroyed_cohort_id, ID, null: false

    def resolve(id:)
      Cohort.find(id).destroy
      { destroyed_cohort_id: id }
    end
  end
end
