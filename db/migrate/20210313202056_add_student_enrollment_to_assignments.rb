class AddStudentEnrollmentToAssignments < ActiveRecord::Migration[6.0]
  def change
    add_column :assignments, :student_enrollment_id, :integer
  end
end
