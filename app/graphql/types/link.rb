module Types
  class Link < Types::BaseObject
    description "link"

    field :label, String, null: true
    field :identifier, String, null: true
  end
end
