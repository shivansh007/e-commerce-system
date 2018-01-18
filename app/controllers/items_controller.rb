class ItemsController < ApplicationController
  protect_from_forgery only: %i[create update destroy]
  before_action :find_item, only: %i[show edit update destroy]

  def index
    @items = Item.all
    respond_to do |format|
      format.html
      format.json { render json: { message: 'Loaded items', items: @items }, status: :ok }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: { message: 'Loaded item', item: @item }, status: :ok }
    end
  end

  def new
    @item = Item.new
  end

  def edit; end

  def create
    @item = Item.create(item_params)
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: { message: 'Created item', item: @item }, status: :ok }
      else
        format.html { render :new }
        format.json { render json: { message: @item.errors }, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render json: { message: 'Updated item', item: @item }, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: { message: @item.errors }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      @item.destroy
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { render json: { message: 'Deleted item', item: nil }, status: :ok }
    end
  end

  private

  def find_item
    @item = Item.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to items_path }
      format.json { render json: { message: 'Not found' }, status: :not_found }
    end
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :stock, :brand, :category_id)
  end
end
