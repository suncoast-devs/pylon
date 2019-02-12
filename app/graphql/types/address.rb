module Types
  class Address < Types::BaseObject
    description "address"

    field :addressable_type, String, null: false
    field :label, String, null: false
    field :street_address, String, null: false
    field :extended_address, String, null: false
    field :locality, String, null: false
    field :region, String, null: false
    field :postal_code, String, null: false
    field :country_name, String, null: false
    field :post_office_box, String, null: false
  end
end
