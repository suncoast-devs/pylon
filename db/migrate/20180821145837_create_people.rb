class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :given_name
      t.string :family_name
      t.string :additional_name
      t.string :honorific_prefix
      t.string :honorific_suffix
      t.string :nickname
      t.string :full_name
      t.string :shirt_size
      t.text :dietary_note

      t.timestamps
    end
  end
end
