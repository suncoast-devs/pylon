class AddTurnedInToAssignment < ActiveRecord::Migration[6.0]
  def change
    add_column :assignments, :turned_in, :bool
  end
end
