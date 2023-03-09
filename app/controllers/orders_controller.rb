class OrdersController < ApplicationController
  before_action :authentication
  before_action :current_user, only: [:create, :update]
  before_action :set_product, :only =>[:create, :show, :update, :destroy , :add_product, :remove_product]
  before_action :add_product, :only=>[:create]


 


  def index
    @orders = current_user.orders.all
    render json: @orders.to_json, status: 201
  end


  def show
    @order = Order.find(params[:id])
    render json: @order.to_json, status: 201
  end


  def create
    byebug
    @order = add_product.cart_product.orders.new(order_params)
    if @order.save
      render json: @order.to_json, status: 201
    else
      render json: {erors: "order not created" }, status: :not_authenticate
    end
  end

  def update
    @order = current_user.orders.find(params[:id])
    if @order.update(order_params)
      render json: @order.to_json, status: 201
    else
      render json: {erors: "can'nt update" }, status: :not_updated
    end
  end


  def total_price
    products.to_a.sum(&:total_price)
  end
  
  private

  def order_params
    params.require(:order).permit(:user_id, :product_id, :cart_id)
  end

  def add_product(product_id)
    byebug
    product = current_user.products.where('product_id = ?', product_id)
    if product
      product.quantity + 1
      product.update(quantity: product)
      product.save
      render json: product.to_json, status: 201
    else
      render json:{error_message: "limit exeed"}, status: :not_found
    end
  end

  def remove()
    product=current_user.products.where('product_id = ?', product_id)
    if product
      product.quantity-1
      product.update(quantity: product)
      product.save
      render json: product.to_json, status: 201
    else
      render json:{error_message: "product is not present"}, status: :not_found
    end
  end

  def set_product
    byebug
    @product=Product.find(params[:product_id])
  end

end
