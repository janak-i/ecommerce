class CartsController < ApplicationController
  before_action :current_user, only: %i[show destroy]

  def show
    @current_cart = Cart.find(params[:cart_id])
    render json: @current_cart.to_json, status: 201
  end

  private
  def cart_params
    params.require(:cart).permit(:total_price, :user_id)
  end
end

