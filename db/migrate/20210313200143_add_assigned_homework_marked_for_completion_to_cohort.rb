class AddAssignedHomeworkMarkedForCompletionToCohort < ActiveRecord::Migration[6.0]
  def change
    add_column :cohorts, :assigned_homework_marked_for_completion_count, :integer, default: 0
  end
end
