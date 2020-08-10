class StudentEnrollmentResource < ApplicationResource
  attribute :cohort_id, :integer
  attribute :person_id, :integer
  attribute :units, :array
  attribute :invitation_code, :string, writable: false
  attribute :active, :boolean
  attribute :auditing, :boolean

  attribute :assign_homework, :boolean do
    @object.assign_homework
  end

  attribute :show_grade, :boolean do
    @object.show_grade
  end

  attribute :generate_progress_report, :boolean do
    @object.generate_progress_report
  end

  extra_attribute :completed_homework_count, :integer do
    @object.person.completed_assignments(@object.cohort_id).count
  end

  extra_attribute :completion_percentage, :float do
    @object.completion_percentage
  end

  extra_attribute :needed_to_complete_count, :integer do
    @object.needed_to_complete_count
  end

  belongs_to :cohort
  belongs_to :person

  def base_scope
    return StudentEnrollment.all.includes(:person, :cohort) if admin?

    StudentEnrollment.where(person_id: current_person.id)
  end
end
