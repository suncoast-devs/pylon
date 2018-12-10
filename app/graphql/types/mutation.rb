module Types
  class Mutation < Types::BaseObject
    field :create_cohort, mutation: Mutations::CreateCohort do
      guard -> (obj, args, ctx) { ctx[:current_user]&.is_admin? }
      mask -> (ctx) { ctx[:current_user]&.is_admin? }
    end

    field :update_cohort, mutation: Mutations::UpdateCohort do
      guard -> (obj, args, ctx) { ctx[:current_user]&.is_admin? }
      mask -> (ctx) { ctx[:current_user]&.is_admin? }
    end

    field :destroy_cohort, mutation: Mutations::DestroyCohort do
      guard -> (obj, args, ctx) { ctx[:current_user]&.is_admin? }
      mask -> (ctx) { ctx[:current_user]&.is_admin? }
    end

    field :create_invitation, mutation: Mutations::CreateInvitation do
      guard -> (obj, args, ctx) { ctx[:current_user]&.is_admin? }
      mask -> (ctx) { ctx[:current_user]&.is_admin? }
    end

    field :destroy_invitation, mutation: Mutations::DestroyInvitation do
      guard -> (obj, args, ctx) { ctx[:current_user]&.is_admin? }
      mask -> (ctx) { ctx[:current_user]&.is_admin? }
    end
  end
end
