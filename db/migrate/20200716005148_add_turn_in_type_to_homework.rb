class AddTurnInTypeToHomework < ActiveRecord::Migration[6.0]
  def change
    add_column :homeworks, :turn_in_type, :string
  end
end
