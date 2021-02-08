class SetDefaultAssignmentTurnedInToFalse < ActiveRecord::Migration[6.0]
  def change
    change_column :assignments, :turned_in, :boolean, default: false
  end
end
