class CreateStudentProgressReports < ActiveRecord::Migration[5.2]
  def change
    create_table :student_progress_reports do |t|
      t.belongs_to :progress_report, foreign_key: true
      t.belongs_to :person, foreign_key: true
      t.json :content

      t.timestamps
    end
  end
end
