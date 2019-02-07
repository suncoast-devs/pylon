module Types
  class Cohort < Types::BaseObject
    description "A group of students enrolled in an Academy program"

    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: true
    field :people, [::Types::Person], null: false do
      admin!
    end
  end
end
