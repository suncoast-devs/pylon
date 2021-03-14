class StudentEnrollmentResource < ApplicationResource
  attribute :cohort_id, :integer
  attribute :person_id, :integer
  attribute :units, :array
  attribute :invitation_code, :string, writable: false
  attribute :active, :boolean
  attribute :auditing, :boolean

  attribute :can_be_assigned_homework, :boolean do
    @object.can_be_assigned_homework
  end

  attribute :show_grade, :boolean do
    @object.show_grade
  end

  attribute :generate_progress_report, :boolean do
    @object.generate_progress_report
  end

  attribute :completed_assignments_count, :integer, writable: false

  attribute :completion_percentage, :float do
    @object.completion_percentage
  end

  attribute :needed_to_complete_count, :integer do
    @object.needed_to_complete_count
  end

  belongs_to :cohort
  belongs_to :person
  has_many :assignments

  def base_scope
    return StudentEnrollment.all.includes(:person, :cohort) if admin?

    StudentEnrollment.where(person_id: current_person.id)
  end
end
