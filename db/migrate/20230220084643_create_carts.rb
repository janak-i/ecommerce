class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.decimal :price
      t.references :user
      t.references :product
      t.references :order


      t.timestamps
    end
  end
end
