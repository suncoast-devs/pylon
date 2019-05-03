class AddDatesToCohort < ActiveRecord::Migration[5.2]
  def change
    add_column :cohorts, :start_date, :date
    add_column :cohorts, :end_date, :date
  end
end
