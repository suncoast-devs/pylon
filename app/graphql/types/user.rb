module Types
  class User < Types::BaseObject
    description "User"

    field :person, [Types::Person]

    field :is_admin, Boolean
    field :auth_sub, String
  end
end
