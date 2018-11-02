class Types::CohortInput < Types::BaseInputObject
  description "Attributes for creating or updating a Cohort"
  argument :name, String, required: false
  argument :description, String, required: false
end
