class CreateApiTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :api_tokens do |t|
      t.string :name, null: false
      t.text :description, default: nil
      t.integer :access_id, null: false
      t.string :secret_key, null: false
      t.string :hostname, null: false
      t.timestamps
    end
  end
end
