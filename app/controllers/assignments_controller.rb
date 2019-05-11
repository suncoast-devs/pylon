class AssignmentsController < GraphitiResourceController
  def update
    saved = false
    record = nil

    ActiveRecord::Base.transaction do
      @record = self.resource.find(params)

      saved = @record.update_attributes

      assignment = @record.data

      if saved
        if assignment.previous_changes.include?(:score)
          AssignmentChangeJob.perform_later(assignment: assignment, type: "graded")
        else
          AssignmentChangeJob.perform_later(assignment: assignment, type: "updated")
        end
      end
    end

    if saved
      render jsonapi: @record
    else
      render jsonapi_errors: @jrecord
    end
  end

  def create
    saved = false
    record = nil

    ActiveRecord::Base.transaction do
      person = Person.find_by(id: params[:data][:attributes][:person_id])

      existing = Assignment.find_by(person_id: params[:data][:attributes][:person_id], homework_id: params[:data][:attributes][:homework_id])
      if existing
        record = self.resource.find(params)

        AssignmentChangeJob.perform_later(assignment: existing, type: "updated")

        saved = true
      else
        record = self.resource.build(params)
        saved = record.save

        if saved
          created_assignment = Assignment.find_by(person_id: params[:data][:attributes][:person_id], homework_id: params[:data][:attributes][:homework_id])
          AssignmentChangeJob.perform_later(assignment: created_assignment, type: "created")
        end
      end
    end

    if saved
      render jsonapi: record, status: 201
    else
      render jsonapi_errors: record
    end
  end
end
