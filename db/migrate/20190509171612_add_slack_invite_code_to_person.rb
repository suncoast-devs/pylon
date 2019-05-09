class AddSlackInviteCodeToPerson < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :slack_invite_code, :string
  end
end
