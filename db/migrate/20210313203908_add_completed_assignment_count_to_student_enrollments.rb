class AddCompletedAssignmentCountToStudentEnrollments < ActiveRecord::Migration[6.0]
  def change
    add_column :student_enrollments, :completed_assignments_count, :integer
  end
end
