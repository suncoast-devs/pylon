class AssignmentEventResource < ApplicationResource
  attribute :id, :integer
  attribute :name, :string
  attribute :payload, :hash
  attribute :assignment_id, :integer
  attribute :person_id, :integer, writable: false
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false

  belongs_to :person
  belongs_to :assignment

  # Ensure that the current user is always assigned as the person for this event
  before_save do |model|
    model.person_id = context.current_user.person_id

    unless %w{grade turnin reopen comment}.include?(model.name)
      raise "ZOMG, NO #{model.name}"
    end

    if model.name == "turnin"
      model.assignment.turned_in = true
    end

    if model.name == "reopen"
      model.assignment.turned_in = false
    end

    if model.name == "grade"
      if context.current_user_is_admin?
        model.assignment.score = model.payload["score"]

        # Reopen the assignment if it is needed
        if model.assignment.issue_state == "open"
          model.assignment.turned_in = false
        end

        AssignmentGradedJob.perform_later(assignment: model.assignment)
      else
        raise "ZOMG, NO"
      end
    end
  end

  def base_scope
    return AssignmentEvent.all if admin?

    # Only see the assignment events for our own assignments
    AssignmentEvent.where(assignment_id: current_user.assignment_ids)
  end
end
