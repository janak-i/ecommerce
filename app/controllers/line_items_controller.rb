class LineItemsController < ApplicationController
	before_action :set_line_item, only: [:show, :edit, :update, :destroy]
	before_action :add_product, only: [:create]
	# before_action :set_cart, only: [:create]
	def index
		@line_items = LineItem.all
		render json: @line_items.to_json, status: :ok
	end

	def show
		@line_item=LineItem.find(params[:id])
		render json: @line_item.to_json, status: :ok
	end

	def update
		@product=Product.find(params[:id])
		if @product.update(product_params)
			render json:{data: @product_to_json}, status: :updated
		else
			render json: {errors: @product_to_json.errors}, status: :unprocessable_entity
		end
	end

	private

	def add_product
		line_item = LineItem.find(params[:product_id])
		if line_item
			line_item.increment(:quantity)
			line_item.save
		else
			line_item = line_items.build(product_id: product.id)
		end
		line_item
	end



	def set_line_item
		byebug
		@line_item = LineItem.find(params[:id])
	end

	def line_item_params
		params.require(:line_item).permit(:product_id)
	end
end
