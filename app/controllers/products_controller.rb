class ProductsController < ApplicationController
  before_action :find_product, only:[:edit, :destroy, :update]

  def index
    @products = Product.available.order(:id)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, notice: "創立成功"
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    if @product.update(product_params)
        redirect_to products_path, notice: "更新成功"
    else
        render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.for_sale = false
    if @product.save
      redirect_to products_path, notice: "刪除成功"
    end
  end

  private
  def find_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :for_sale, :inventory)
  end
end
