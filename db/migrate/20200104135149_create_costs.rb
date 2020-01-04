class CreateCosts < ActiveRecord::Migration[5.1]
  def change
    create_table :costs do |t|
      t.string :description, null: false
      t.decimal :price, null: false, default: 0, precision: 8, scale: 2
      t.integer :amount, null: false, default: 1
      t.integer :vat, null: false, default: 21

      t.belongs_to :note
    end
  end
end
