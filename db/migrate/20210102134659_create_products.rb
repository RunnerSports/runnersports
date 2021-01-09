class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.text :description
      t.integer :price, null: false
      t.boolean :for_sale, default: true
      t.integer :inventory

      t.timestamps
    end
  end
end
