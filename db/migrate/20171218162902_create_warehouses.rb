class CreateWarehouses < ActiveRecord::Migration[5.1]
  def change
    create_table :warehouses do |t|
      t.string :name, null: false
      t.integer :distribution_center_id
      t.timestamps
      t.index [:distribution_center_id]
    end
  end
end
