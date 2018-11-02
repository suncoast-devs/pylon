module Mutations
  class DestroyInvitation < Mutations::BaseMutation
    argument :id, ID, required: true

    field :destroyed_invitation_id, ID, null: false

    def resolve(id:)
      Invitation.find(id).destroy
      {destroyed_invitation_id: id}
    end
  end
end
