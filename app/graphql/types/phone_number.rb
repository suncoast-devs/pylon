module Types
  class PhoneNumber < Types::BaseObject
    description "Phone Number"

    field :label, String, null: false
    field :tel, String, null: false
    field :is_sms_capable, Boolean, null: false
    field :person, [Types::Person], null: false
  end
end
