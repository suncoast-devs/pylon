module Types
  class Mutation < Types::BaseObject
    field :create_cohort, mutation: Mutations::CreateCohort do
      admin!
    end

    field :update_cohort, mutation: Mutations::UpdateCohort do
      admin!
    end

    field :destroy_cohort, mutation: Mutations::DestroyCohort do
      admin!
    end

    field :create_invitation, mutation: Mutations::CreateInvitation do
      admin!
    end

    field :destroy_invitation, mutation: Mutations::DestroyInvitation do
      admin!
    end

    field :update_profile, mutation: Mutations::UpdateProfile do
      logged_in!
    end
  end
end
