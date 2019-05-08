class AssignmentIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :assignments, [:homework_id, :person_id], unique: true
  end
end
