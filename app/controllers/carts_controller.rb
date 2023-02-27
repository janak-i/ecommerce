class CartsController < ApplicationController

	def add_item(product_id)
		byebug
		product = products.where('product_id = ?', product_id).first
		if product
			product.quantity + 1
			product.save
		else
			product = Product.find(product_id)
			products << product
		end
	end
end
