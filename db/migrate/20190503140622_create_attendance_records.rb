class CreateAttendanceRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :attendance_records do |t|
      t.belongs_to :person, foreign_key: true
      t.belongs_to :cohort_date, foreign_key: true
      t.string :status, limit: 1
      t.string :note

      t.timestamps
    end
  end
end
