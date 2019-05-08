class AssignmentsController < GraphitiResourceController
  def update
    super

    assignment = @record.data
    if assignment.previous_changes.include?(:score)
      GithubIssueInterface.comment_on_assignment(assignment)
    end
  end

  def create
    person = Person.find_by(id: params[:data][:attributes][:person_id])

    existing = Assignment.find_by(person_id: params[:data][:attributes][:person_id], homework_id: params[:data][:attributes][:homework_id])
    if existing
      record = self.resource.find(params)

      GithubIssueInterface.update(person, existing)

      saved = true
    else
      record = self.resource.build(params)
      saved = record.save

      if saved
        created_assignment = Assignment.find_by(person_id: params[:data][:attributes][:person_id], homework_id: params[:data][:attributes][:homework_id])
        GithubIssueInterface.create(person, created_assignment)
      end
    end

    if saved
      render jsonapi: record, status: 201
    else
      render jsonapi_errors: record
    end
  end
end
