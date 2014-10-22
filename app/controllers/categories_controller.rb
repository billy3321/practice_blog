class CategoriesController < ApplicationController
  #before_action :set_category, only: [:show, :edit, :update, :destroy, :create]
  before_action :set_category, except: [:index, :new]
  before_action :authenticate_user!

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all.page params[:page]
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @articles = @category.articles.order(created_at: :desc).page params[:page]
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  def create
    @category = Category.new(category_params)
    if @category.save
        redirect_to @category, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
    redirect_to categories_url, notice: 'Category was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = params[:id] ? Category.find(params[:id]) : Category.new(category_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name)
    end
end
