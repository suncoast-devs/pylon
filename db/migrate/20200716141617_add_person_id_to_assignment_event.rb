class AddPersonIdToAssignmentEvent < ActiveRecord::Migration[6.0]
  def change
    add_reference :assignment_events, :person, null: false, foreign_key: true
  end
end
