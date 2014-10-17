class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :create]
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all.page params[:page]
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article.job = @article.get_job()
    @comments = @article.comments.order(created_at: :asc).page params[:page]
    @comment = @article.comments.build
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    puts @article.inspect
  end

  # POST /articles
  # POST /articles.json
  def create
    if @article.save
      #render
      if @article.job
        @article.set_job(@article.job)
      end
      redirect_to @article, notice: 'Article was successfully created.'
      #format.json { render :show, status: :created, location: @article }
    else
      #render
      render :new
      #format.json { render json: @article.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    #respond_to do |format|
    if @article.update(article_params)
      if @article.job
        @article.set_job(@article.job)
      end
      redirect_to @article, notice: 'Article was successfully updated.'
        #format.json { render :show, status: :ok, location: @article }
    else
      render :edit
        #format.json { render json: @article.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    @article.set_job(nil)
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
    #respond_to do |format|
      #format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      #format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = params[:id] ? Article.find(params[:id]) : Article.new(article_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:user_id, :title, :content, :category_id, :job)
    end
end
