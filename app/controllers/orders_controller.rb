class OrdersController < ApplicationController
  protect_from_forgery only: %i[create update destroy]
  before_action :find_order, only: %i[show edit update destroy]

  def index
    @orders = Order.all
    respond_to do |format|
      format.html
      format.json { render json: { message: 'Loaded orders', orders: @orders }, status: :ok }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: { message: 'Loaded order', order: @order }, status: :ok }
    end
  end

  def new
    @order = Order.new
  end

  def edit; end

  def create
    @order = Order.create(order_params)
    respond_to do |format|
      if @order.save
        Invoice.create(order_id: @order.id)
        @order.item.update(stock: (@order.item.stock - 1))
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render json: { message: 'Created order', order: @order }, status: :ok }
      else
        format.html { render :new }
        format.json { render json: { message: @order.errors }, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render json: { message: 'Updated order', order: @order }, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: { message: @order.errors }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      @order.destroy
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { render json: { message: 'Deleted order', order: nil }, status: :ok }
    end
  end

  private

  def find_order
    @order = Order.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to orders_path }
      format.json { render json: { message: 'Not found' }, status: :not_found }
    end
  end

  def order_params
    params.require(:order).permit(:item_id, :user_id, :payment_mode, :payment_status, :order_status)
  end
end
