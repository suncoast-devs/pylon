module Types
  class Note < Types::BaseObject
    description "note"

    field :label, String
    field :message, String
    field :user, [Types::User], null: false
  end
end
