class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.timestamps
      t.integer :kind, null: false, default: 0
      t.string :note_number, null: false
      t.string :title, null: false
      t.binary :generated_pdf, :limit => 16.megabyte

      t.belongs_to :contact
    end
  end
end
