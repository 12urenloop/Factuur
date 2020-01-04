class AddDeletedAtToCost < ActiveRecord::Migration[5.1]
  def change
    add_column :costs, :deleted_at, :datetime
    add_index :costs, :deleted_at
  end
end
