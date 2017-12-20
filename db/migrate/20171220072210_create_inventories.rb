class CreateInventories < ActiveRecord::Migration[5.1]
  def change
    create_table :inventories do |t|
      t.integer :product_id, null: false
      t.integer :warehouse_id, null: false
      t.integer :count
      t.timestamps
    end
  end
end
