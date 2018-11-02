module Mutations
  class CreateInvitation < Mutations::BaseMutation
    argument :input, Types::InvitationInput, required: true

    field :invitation, Types::Invitation, null: true
    field :errors, [String], null: false

    def resolve(input:)
      invitation = Invitation.new(input.to_h)
      if invitation.save
        {
          invitation: invitation,
          errors: []
        }
      else
        {
          invitation: nil,
          errors: invitation.errors.full_messages
        }
      end
    end
  end
end
