class AddColumnToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :stripe_plan_name, :string
    add_column :products, :paypal_plan_name, :string
  end
  add_money :products, :price, currency: { present: true }
end
