class AddAuditingToStudentEnrollment < ActiveRecord::Migration[6.0]
  def change
    add_column :student_enrollments, :auditing, :boolean, default: false
  end
end
