class MoveInvitationToStudentEnrollment < ActiveRecord::Migration[5.2]
  def change
    drop_table :invitations
    add_column :student_enrollments, :invitation_code, :string
  end
end
