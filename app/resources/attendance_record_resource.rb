class AttendanceRecordResource < ApplicationResource
  attribute :id, :integer
  attribute :person_id, :integer
  attribute :cohort_date_id, :integer
  attribute :status, :string
  attribute :note, :string, readable: :admin?
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false

  belongs_to :person
  belongs_to :cohort_date

  def base_scope
    return AttendanceRecord.all if admin?

    current_user.attendance_records
  end
end
