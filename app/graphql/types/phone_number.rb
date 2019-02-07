module Types
  class PhoneNumber < Types::BaseObject
    description "Phone Number"

    field :label, String
    field :tel, String
    field :is_sms_capable, Boolean
    field :person, [Types::Person], null: false
  end
end
