module Types
  class Program < Types::BaseObject
    description "Program"

    field :title, String, null: false
    field :identifier, String, null: false
    field :description, String, null: false
  end
end
