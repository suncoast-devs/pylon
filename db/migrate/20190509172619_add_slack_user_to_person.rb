class AddSlackUserToPerson < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :slack_user, :string
  end
end
