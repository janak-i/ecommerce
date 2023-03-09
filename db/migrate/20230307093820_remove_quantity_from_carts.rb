class RemoveQuantityFromCarts < ActiveRecord::Migration[7.0]
  def change
    remove_column :carts, :quantity, :integer
  end
end
