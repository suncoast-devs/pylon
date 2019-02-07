module Types
  class Person < Types::BaseObject
    description "A person"

    field :id, ID, null: false
    field :given_name, String, null: false
    field :family_name, String, null: false

    field :links, [Types::Link], null: true

    field :profile, Types::StudentProfile, null: true
    field :programs, [Types::Program], null: true
    field :cohorts, [Types::Cohort], null: true
  end
end
