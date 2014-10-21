class ProductGroupController < ApplicationController

  def index
    @product_group = ProductGroup.all.page params[:page]
  end

  # GET /product_groups/1
  # GET /product_groups/1.json
  def show
  end

  # GET /product_groups/new
  def new
    @product_group = ProductGroup.new
  end

  # GET /product_groups/1/edit
  def edit
  end

  # POST /product_groups
  # POST /product_groups.json
  def create
    @product_group = ProductGroup.new(product_group_params)
    if @product_group.save
        redirect_to @product_group, notice: 'ProductGroup was successfully created.'
    else
      render :new
    end

    # respond_to do |format|
    #   if @product_group.save
    #     format.html { redirect_to @product_group, notice: 'ProductGroup was successfully created.' }
    #     #format.json { render :show, status: :created, location: @product_group }
    #   else
    #     format.html { render :new }
    #     #format.json { render json: @product_group.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /product_groups/1
  # PATCH/PUT /product_groups/1.json
  def update
    respond_to do |format|
      if @product_group.update(product_group_params)
        format.html { redirect_to @product_group, notice: 'ProductGroup was successfully updated.' }
        #format.json { render :show, status: :ok, location: @product_group }
      else
        format.html { render :edit }
        #format.json { render json: @product_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_groups/1
  # DELETE /product_groups/1.json
  def destroy
    @product_group.destroy
    respond_to do |format|
      format.html { redirect_to product_groups_url, notice: 'ProductGroup was successfully destroyed.' }
      #format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_group
      @product_group = params[:id] ? ProductGroup.find(params[:id]) : ProductGroup.new(product_group_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_group_params
      params.require(:product_group).permit(:name)
    end
end

