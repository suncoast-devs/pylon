class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.references :cohort, foreign_key: true
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
