class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.references :person, foreign_key: true
      t.boolean :is_admin
      t.string :auth_sub

      t.timestamps
    end
  end
end
