class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references :addressable, polymorphic: true
      t.string :label
      t.string :street_address
      t.string :extended_address
      t.string :locality
      t.string :region
      t.string :postal_code
      t.string :country_name
      t.string :post_office_box

      t.timestamps
    end
  end
end
