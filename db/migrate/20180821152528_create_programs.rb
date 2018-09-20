class CreatePrograms < ActiveRecord::Migration[5.2]
  def change
    create_table :programs do |t|
      t.string :title
      t.string :identifier
      t.text :description

      t.timestamps
    end
  end
end
