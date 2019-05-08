class RemoveDescriptionFromCohort < ActiveRecord::Migration[5.2]
  def change
    remove_column :cohorts, :description
  end
end
