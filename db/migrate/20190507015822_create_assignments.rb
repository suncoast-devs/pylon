class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.integer :score
      t.integer :issue
      t.belongs_to :homework, foreign_key: true
      t.belongs_to :person, foreign_key: true

      t.timestamps
    end
  end
end
