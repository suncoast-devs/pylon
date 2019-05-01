class DropProgramFromStudentEnrolments < ActiveRecord::Migration[5.2]
  def change
    remove_column :student_enrollments, :program_id
  end
end
