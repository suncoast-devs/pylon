module Types
  class User < Types::BaseObject
    description "User"

    field :person, [Types::Person], null: false

    field :is_admin, Boolean, null: false
  end
end
