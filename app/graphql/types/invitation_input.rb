class Types::InvitationInput < Types::BaseInputObject
  description "Attributes for creating or updating an Invitation"
  argument :name, String, required: false
  argument :email, String, required: false
  argument :cohort_id, Integer, required: false
end
