class CreateAssignmentEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :assignment_events do |t|
      t.string :name
      t.string :payload
      t.belongs_to :assignment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
