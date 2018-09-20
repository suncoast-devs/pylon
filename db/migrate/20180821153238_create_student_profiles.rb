class CreateStudentProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :student_profiles do |t|
      t.references :person, foreign_key: true
      t.references :cohort, foreign_key: true
      t.references :program, foreign_key: true
      t.string :status
      t.boolean :is_looking_for_work
      t.boolean :is_available_for_freelance
      t.string :specialty

      t.timestamps
    end
  end
end
