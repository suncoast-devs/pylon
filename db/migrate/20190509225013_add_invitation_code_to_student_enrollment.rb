class AddInvitationCodeToStudentEnrollment < ActiveRecord::Migration[5.2]
  def change
    add_column :student_enrollments, :invitation_code, :string
  end
end
