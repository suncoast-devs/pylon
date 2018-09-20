class CreatePhoneNumbers < ActiveRecord::Migration[5.2]
  def change
    create_table :phone_numbers do |t|
      t.references :person, foreign_key: true
      t.string :label
      t.string :tel
      t.boolean :is_sms_capable

      t.timestamps
    end
  end
end
