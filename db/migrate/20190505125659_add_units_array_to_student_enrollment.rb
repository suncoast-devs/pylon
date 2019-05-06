class AddUnitsArrayToStudentEnrollment < ActiveRecord::Migration[5.2]
  def change
    add_column :student_enrollments, :units, :integer, array: true, default: []
    remove_column :student_enrollments, :unit_id
  end
end
