class AddCountToHomework < ActiveRecord::Migration[5.2]
  def change
    add_column :homeworks, :assignments_count, :integer
  end
end
