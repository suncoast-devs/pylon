class MoveAssignmentsRepoFromUserToPerson < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :assignments_repo, :string, default: "assignments"
    remove_column :users, :assignments_repo
  end
end
