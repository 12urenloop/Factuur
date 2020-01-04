class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :beneficiary
      t.string :street, null: false
      t.string :zip_code, null: false
      t.string :city, null: false
      t.string :country, null: false

      t.belongs_to :contact, null: false
    end
  end
end
