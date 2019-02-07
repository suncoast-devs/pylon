module Types
  class StudentProfile < Types::BaseObject
    description "Student Profile"

    field :person, [Types::Person], null: false

    field :status, String, null: true
    field :speciality, String, null: true
    field :is_looking_for_work, Boolean, null: false
    field :is_available_for_freelance, Boolean, null: false
  end
end
