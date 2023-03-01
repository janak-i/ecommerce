class OrdersController < ApplicationController

  def index
    byebug
    @orders = Order.all
    @orders = if params[:search]
                Order.search(params[:search]).order('created_at ASC')
                     .paginate(page: params[:page], per_page: 5)
              else
                @orders.order('created_at ASC')
                       .paginate(page: params[:page], per_page: 5)
              end
  end


  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @cart = @current_cart
  end

  def create
  	byebug
    @order = Order.new(order_params)
    @order.update(user_id: @current_user.id)
    @order.save!
    render json: @order, status: 201
  end

  
  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_path }
      format.json { head :no_content }
      flash[:info] = 'Order was successfully destroyed.'
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to orders_path
  end

  def cart_is_empty
    return unless @current_cart.line_items.empty?

    store_location
    flash[:danger] = 'You cart is empty!'
    redirect_to cart_path(@current_cart)
  end

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
    params.require(:order).permit(:user_id, :product_id)
  end
end
