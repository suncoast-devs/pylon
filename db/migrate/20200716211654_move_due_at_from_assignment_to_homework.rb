class MoveDueAtFromAssignmentToHomework < ActiveRecord::Migration[6.0]
  def change
    add_column :homeworks, :due_at, :datetime
    remove_column :assignments, :due_at, :datetime
  end
end
