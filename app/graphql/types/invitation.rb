module Types
  class Invitation < Types::BaseObject
    description "An invitation to use the system"

    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    # field :cohort, Types::Cohort, null: false
  end
end
