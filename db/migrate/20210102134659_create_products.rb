class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.text :description
      t.integer :price, null: false
      t.boolean :status, default: true
      t.integer :amount

      t.timestamps
    end
  end
end
