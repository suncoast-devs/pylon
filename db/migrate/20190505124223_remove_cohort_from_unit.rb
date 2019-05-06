class RemoveCohortFromUnit < ActiveRecord::Migration[5.2]
  def change
    remove_column :units, :cohort_id
  end
end
