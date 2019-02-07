module Types
  class Address < Types::BaseObject
    description "address"

    field :addressable_type, String
    field :label, String
    field :street_address, String
    field :extended_address, String
    field :locality, String
    field :region, String
    field :postal_code, String
    field :country_name, String
    field :post_office_box, String
  end
end
