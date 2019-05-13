class AddCompletedToProgressReport < ActiveRecord::Migration[5.2]
  def change
    add_column :progress_reports, :completed, :boolean, default: false, nullable: false
  end
end
