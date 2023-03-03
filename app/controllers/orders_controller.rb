class OrdersController < ApplicationController
  # before_action :add_line_items_to_order, only: [:create]
  before_action :current_user, only: [:create]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]


  def index
    byebug
    @orders = current_user.orders.all
    render json: @orders.to_json, status: 201
  end


  def show
    @order = Order.find(params[:id])
    render json: @order.to_json, status: 201
  end


  def order
    @order = Order.new
  end

  def create
    byebug
    @order = current_user.orders.new(order_params)
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

  # def cart_is_empty
  #   return unless @current_cart.line_items.empty?
  #   render json: {:message, "cart is empty"}
  # end

  private

  def add_line_items_to_order
    @current_cart.line_items.each do |item|
      item.cart_id = nil
      item.order_id = @order.id
      item.save
      @order.line_items << item
    end
  end

  def reset_sessions_cart
    Cart.destroy(session[:cart_id])
    session[:cart_id] = nil
  end

  def order_params
    params.require(:order).permit(:user_id, :product_id, :cart_id)
  end
end
