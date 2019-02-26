class Types::ProfileInput < Types::BaseInputObject
  description "Attributes for creating or updating a Profile"
  argument :full_name, String, required: false
  argument :given_name, String, required: false
  argument :family_name, String, required: false
  argument :additional_name, String, required: false
  argument :honorific_prefix, String, required: false
  argument :honorific_suffix, String, required: false
  argument :nickname, String, required: false
  argument :shirt_size, String, required: false
  argument :dietary_note, String, required: false
end

module Mutations
  class UpdateProfile < Mutations::BaseMutation
    argument :profile, Types::ProfileInput, required: true

    field :me, Types::Person, null: true
    field :errors, [String], null: false

    def resolve(profile:)
      user = context[:current_user]
      person = user.person

      if person.update(profile.to_h)
        {
          me: person,
          errors: []
        }
      else
        {
          me: nil,
          errors: person.errors.full_messages
        }
      end
    end
  end
end
