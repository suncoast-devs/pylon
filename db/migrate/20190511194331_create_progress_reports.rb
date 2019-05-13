class CreateProgressReports < ActiveRecord::Migration[5.2]
  def change
    create_table :progress_reports do |t|
      t.belongs_to :cohort, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :ids_of_homeworks, array: true, default: []
      t.integer :ids_of_people, array: true, default: []

      t.timestamps
    end
  end
end
