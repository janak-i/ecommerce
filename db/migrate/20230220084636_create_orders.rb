class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user
      t.references :product

      t.timestamps
    end
  end
end
