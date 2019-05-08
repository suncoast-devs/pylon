class RenameUsersNickname < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :nickname, :github
  end
end
