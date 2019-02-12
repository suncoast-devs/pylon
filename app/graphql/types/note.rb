module Types
  class Note < Types::BaseObject
    description "note"

    field :label, String, null: false
    field :message, String, null: false
    field :user, [Types::User], null: false
  end
end
