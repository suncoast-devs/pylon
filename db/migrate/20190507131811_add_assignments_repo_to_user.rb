class AddAssignmentsRepoToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :assignments_repo, :string, default: "assignments"
  end
end
