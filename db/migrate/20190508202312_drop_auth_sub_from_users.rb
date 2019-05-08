class DropAuthSubFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :auth_sub
  end
end
