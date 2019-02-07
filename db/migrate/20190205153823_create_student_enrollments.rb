class CreateStudentEnrollments < ActiveRecord::Migration[5.2]
  def change
    create_table :student_enrollments do |t|
      t.belongs_to :person, foreign_key: true
      t.belongs_to :cohort, foreign_key: true
      t.belongs_to :program, foreign_key: true

      t.timestamps
    end
  end
end
