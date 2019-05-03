class CreateCohortDates < ActiveRecord::Migration[5.2]
  def change
    create_table :cohort_dates do |t|
      t.belongs_to :cohort, foreign_key: true
      t.date :day
      t.string :description, default: "Program Day"

      t.timestamps
    end
  end
end
