class CategoriesController < ApplicationController
  protect_from_forgery only: %i[create update destroy]
  before_action :find_category, only: %i[show edit update destroy]

  def index
    @categories = Category.all
    respond_to do |format|
      format.html
      format.json { render json: { message: 'Loaded categories', categories: @categories }, status: :ok }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: { message: 'Loaded category', category: @category }, status: :ok }
    end
  end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.create(category_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render json: { message: 'Created category', category: @category }, status: :ok }
      else
        format.html { render :new }
        format.json { render json: { message: @category.errors }, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render json: { message: 'Updated category', category: @category }, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: { message: @category.errors }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      @category.destroy
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { render json: { message: 'Deleted category', category: nil }, status: :ok }
    end
  end

  private

  def find_category
    @category = Category.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to categories_path }
      format.json { render json: { message: 'Not found' }, status: :not_found }
    end
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
