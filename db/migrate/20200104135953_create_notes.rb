class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.timestamps
      t.integer :kind, null: false, default: 0
      t.string :_id, null: false
      t.string :title, null: false
      t.binary :generated_pdf

      t.belongs_to :contact
    end
  end
end
