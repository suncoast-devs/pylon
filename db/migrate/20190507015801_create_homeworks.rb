class CreateHomeworks < ActiveRecord::Migration[5.2]
  def change
    create_table :homeworks do |t|
      t.string :name
      t.text :body
      t.string :summary
      t.boolean :counts_towards_completion
      t.belongs_to :cohort, foreign_key: true

      t.timestamps
    end
  end
end
