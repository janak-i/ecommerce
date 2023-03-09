class CreateCartProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_products do |t|
      t.integer :quantity
      t.references :cart
      t.references :product

      t.timestamps
    end
  end
end
