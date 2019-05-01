class AddUnitsToStudentEnrollments < ActiveRecord::Migration[5.2]
  def change
    add_reference :student_enrollments, :unit, foreign_key: true
  end
end
