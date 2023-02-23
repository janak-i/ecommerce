class Cart < ApplicationRecord
  has_many :products
  belongs_to :user
  belongs_to :product
  belongs_to :order

  def add_item(product_id)
    product = products.where('product_id = ?', product_id).first
    if product
      product.quantity + 1
      product.save
    else
      product = Product.find(product_id)
      products << product
    end
  end


  def total_price
    products.to_a.sum(&:full_price)
  end
end


