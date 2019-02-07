module Types
  class Query < Types::BaseObject
    description "The query root of the Pylon schema"

    field :me, Types::Person, null: false do
      description "Your profile and data you can see"

      logged_in!
    end

    def me
      context[:current_user].person
    end

    field :cohort, Types::Cohort, null: true do
      description "Find a cohort by ID"
      argument :id, ID, required: true

      logged_in!
    end

    def cohort(id:)
      ::Cohort.find(id)
    end

    field :cohorts, [Types::Cohort], null: false do
      description "List all cohorts"

      logged_in!
    end

    def cohorts
      ::Cohort.all
    end

    field :invitation, Types::Invitation, null: true do
      description "Find an invitation by ID"
      argument :id, ID, required: true

      admin!
    end

    def invitation(id:)
      ::Invitation.find(id)
    end

    field :invitations, [Types::Invitation], null: false do
      description "List all invitations"

      admin!
    end

    def invitations
      ::Invitation.all
    end
  end
end
