class ProductsController < ApplicationController 
  # before_action :current_user, :only => [:index, :edit, :update, :destroy]
  # before_action :is_admin, :only => [:create]

  def index
    @products=Product.all
    render json: @products.to_json, status: :ok
  end

  def show 
  	@product=Product.find(params[:product_id])
    if @product.present?
      render json: @product.to_json, status: :ok
    else
      render json: {errors: "Id not found"}, status: :unprocessable_entity
    end
  end

  def new
    @product = Product.new
  end

  def edit
    Product.find(params[:id])
  end


  def create
    byebug
    @product = Product.new(product_params)
    if @product.save
      render json: @product.to_json, status: :created
    else
      render json: {erors: "product not created" }, status: :not_found
    end
  end

  def update
    @product=Product.find(params[:id])
    if @product.update(product_params)
      render json:{data: @product_to_json}, status: :updated
    else
      render json: {errors: @product_to_json.errors}, status: :unprocessable_entity
    end
  end

  def destroys
    @product=Product.find(params[:id])
    if @product.destroy
      render json:{data: @product_to_json}, status: :deleted
    else
      render json:{errors: "product not_found"}, status: :not_found
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description,  :price, :cart_id)
  end

end
