class CreateEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :emails do |t|
      t.references :person, foreign_key: true
      t.string :label
      t.string :address
      t.boolean :is_primary

      t.timestamps
    end
  end
end
