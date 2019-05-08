class AssignmentResource < ApplicationResource
  attribute :id, :integer
  attribute :score, :integer
  attribute :issue, :integer
  attribute :homework_id, :integer
  attribute :person_id, :integer
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false

  belongs_to :homework
  belongs_to :person

  def base_scope
    return Assignment.all if admin?

    current_user.assignments
  end
end
