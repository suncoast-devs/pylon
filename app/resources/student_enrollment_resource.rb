class StudentEnrollmentResource < ApplicationResource
  attribute :cohort_id, :integer
  attribute :person_id, :integer
  attribute :units, :array
  attribute :invitation_code, :string, writable: false
  attribute :active, :boolean
  attribute :auditing, :boolean

  attribute :assign_homework, :boolean do
    @object.active
  end

  attribute :show_grade, :boolean do
    @object.active && !@object.auditing
  end

  attribute :generate_progress_report, :boolean do
    @object.active && !@object.auditing
  end

  belongs_to :cohort
  belongs_to :person

  def base_scope
    StudentEnrollment.all.includes(:person)
  end
end
