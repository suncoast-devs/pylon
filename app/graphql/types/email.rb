module Types
  class Email < Types::BaseObject
    description "email"

    field :id, ID, null: false
    field :label, String, null: false
    field :address, String, null: true
    field :is_primary, Boolean, null: true

    field :person, ::Types::Person, null: false
  end
end
