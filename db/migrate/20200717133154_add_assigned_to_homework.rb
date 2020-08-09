class AddAssignedToHomework < ActiveRecord::Migration[6.0]
  def change
    add_column :homeworks, :assigned, :boolean, default: false
  end
end
