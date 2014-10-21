class ProductController < ApplicationController

  def index
    @products = @product_group.products.all.paginate(:page => params[:page], :per_page => 30)
    @product = @product_group.products.build
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = @product_group.product.build(params[:product])
    @product = Product.new(product_params)
    if @product.save
        redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end

    # respond_to do |format|
    #   if @product.save
    #     format.html { redirect_to @product, notice: 'Product was successfully created.' }
    #     #format.json { render :show, status: :created, location: @product }
    #   else
    #     format.html { render :new }
    #     #format.json { render json: @product.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        #format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        #format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      #format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = params[:id] ? Product.find(params[:id]) : Product.new(product_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name)
    end
end