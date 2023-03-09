class CartProductsController < ApplicationController
  before_action :current_user, only: %i[create destroy add_quantity reduce_quantity]
	def create
		byebug
		chosen_product = Product.find(params[:product_id])
		add_products_to_cart(chosen_product)
		if @cart_product.save
			render json: @cart_product.to_json, status: 201
		else
			render json:{error_message: "error adding product"}, status: :not_found
		end
	end


	def destroy
		@cart_product = CartProduct.find(params[:id])
		if @cart_product.destroy
			render json: @cart_product.to_json, status: :deleted
		else
			render json: {error_message: "could not delete without an id"}
		end
	end

	def add_quantity
		@cart_product = CartProduct.find(params[:product_id])
		@cart_product.quantity += 1
		if @cart_product.save
			render json: @cart_product.to_json, status: :created
		else
			render json: {error_message: "cant added"}
		end
	end


	def reduce_quantity
		@cart_product = CartProduct.find(params[:id])
		if @cart_product.quantity > 1
			@line_item.quantity -= 1
			@line_item.save
			redirect_back(fallback_location: @current_cart)
		elsif @line_item.quantity == 1
			destroy
		end
	end

	private

	def cart_product_params
		params.require(:cart_product).permit(:quantity, :cart_id, :product_id)
	end

	def add_products_to_cart(chosen_product)
		byebug
		if @current_cart.products.include?(chosen_product)
			@cart_product = @current_cart.cart_products.find_by(product_id: chosen_product)
			@cart_product.quantity += 1
		else
			@cart_product = CartProduct.new
			@cart_product.cart = @current_cart
			@cart_product.product = chosen_product
			@cart_product.quantity = 1
		end
	end
end
