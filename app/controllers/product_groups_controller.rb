class ProductGroupsController < ApplicationController

  before_action :set_product_group, only: [:show, :edit, :update, :destroy, :create]

  def index
    @product_groups = ProductGroup.all.page params[:page]
  end

  # GET /product_groups/1
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
  def create
    @product_group = ProductGroup.new(product_group_params)
    if @product_group.save
        redirect_to @product_group, notice: 'ProductGroup was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /product_groups/1
  def update
    if @product_group.update(product_group_params)
      redirect_to @product_group, notice: 'ProductGroup was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /product_groups/1
  def destroy
    @product_group.destroy
    redirect_to product_groups_url, notice: 'ProductGroup was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_group
      @product_group = params[:id] ? ProductGroup.find(params[:id]) : ProductGroup.new(product_group_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_group_params
      params.require(:product_group).permit(:name, :item_ids => [])
    end
end

