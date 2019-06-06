class AddDatesToAssignment < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :due_at, :timestamp
  end
end
