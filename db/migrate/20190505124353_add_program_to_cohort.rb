class AddProgramToCohort < ActiveRecord::Migration[5.2]
  def change
    add_reference :cohorts, :program, foreign_key: true
  end
end
