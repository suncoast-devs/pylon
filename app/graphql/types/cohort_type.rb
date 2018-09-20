module Types
  class CohortType < Types::BaseObject
    description "A group of students enrolled in an Academy program"

    global_id_field :id
    field :name, String, null: false
    field :description, String, null: true
  end
end
