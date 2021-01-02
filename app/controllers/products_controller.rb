class ProductsController < ApplicationController
  before_action :find_product

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      redirect_to root_path
    end
  end

  private
  def find_product

  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :status, :amount)
  end
end