class RemoveCohortPersonFromProfile < ActiveRecord::Migration[5.2]
  def change
    remove_column :student_profiles, :cohort_id
    remove_column :student_profiles, :program_id
  end
end
