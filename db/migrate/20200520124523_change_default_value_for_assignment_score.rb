class ChangeDefaultValueForAssignmentScore < ActiveRecord::Migration[6.0]
  def change
    # -1 will indicate not graded. This will allow us to mark an assignment "unacceptable" (0) and have it reopen the homework
    change_column_default :assignments, :score, -1
  end
end
