class DefaultAssignmentsCountToZero < ActiveRecord::Migration[6.0]
  def change
    change_column :homeworks, :assignments_count, :integer, default: 0
  end
end
