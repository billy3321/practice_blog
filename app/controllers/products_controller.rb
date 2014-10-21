class ProductsController < ApplicationController

  before_filter :find_product_group
  before_action :set_product, only: [:show, :edit, :update, :destroy, :create]

  def index
    @products = @product_group.products.all
    @product = @product_group.products.build
  end

  # GET /product_group/#{product_group_id}/products/1
  def show
  end

  # GET /product_group/#{product_group_id}/products/new
  def new
    @product = Product.new
  end

  # GET /product_group/#{product_group_id}/products/1/edit
  def edit
  end

  # POST /product_group/#{product_group_id}/products/
  def create
    #@product = @product_group.product.build(params[:product])
    @product = Product.new(product_params)
    if @product.save
        redirect_to product_group_product_path(@product_group, @product), notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /product_group/#{product_group_id}/products/1
  def update
    if @product.update(product_params)
      redirect_to product_group_product_path(@product_group, @product), notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /product_group/#{product_group_id}/products/1
  def destroy
    @product.destroy
    redirect_to product_group_product_path(@product_group), notice: 'Product was successfully destroyed.'
  end

  private

    def find_product_group
      @product_group = ProductGroup.find(params[:product_group_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = params[:id] ? Product.find(params[:id]) : Product.new(product_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name)
    end
end
