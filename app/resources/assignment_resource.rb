class AssignmentResource < ApplicationResource
  attribute :id, :integer
  attribute :score, :integer
  attribute :issue, :integer
  attribute :homework_id, :integer
  attribute :person_id, :integer
  attribute :student_enrollment_id, :integer
  attribute :turned_in, :boolean
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false

  belongs_to :student_enrollment
  belongs_to :homework
  belongs_to :person
  has_many :assignment_events

  attribute :completed, :boolean do
    @object.score >= Assignment::ACCEPTABLE
  end

  attribute :overdue, :boolean do
    Time.now.end_of_day > (@object.homework.due_at || @object.created_at + 1.day).end_of_day
  end

  def base_scope
    return Assignment.all if admin?

    current_user.assignments
  end
end
