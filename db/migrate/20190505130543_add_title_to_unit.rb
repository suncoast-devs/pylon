class AddTitleToUnit < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :title, :string
  end
end
