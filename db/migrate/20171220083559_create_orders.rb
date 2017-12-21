class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :inventory_id, null: false
      t.integer :total, null: false
      t.string :shipping_status
      t.integer :customer_id, null: false
      t.integer :sales_person_id, null: false
      t.timestamps
    end
  end
end
