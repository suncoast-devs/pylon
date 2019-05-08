class ChangeAssignmentScoreDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :assignments, :score, 0
  end
end
