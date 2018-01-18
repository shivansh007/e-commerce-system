class InvoicesController < ApplicationController
  protect_from_forgery only: %i[create update destroy]
  before_action :find_invoice, only: %i[show edit update destroy]

  def index
    @invoices = Invoice.all
    respond_to do |format|
      format.html
      format.json { render json: { message: 'Loaded invoices', invoices: @invoices }, status: :ok }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: { message: 'Loaded invoice', invoice: @invoice }, status: :ok }
    end
  end

  def new
    @invoice = Invoice.new
  end

  def edit; end

  def create
    @invoice = Invoice.create(invoice_params)
    respond_to do |format|
      if @invoice.save
        format.html { redirect_to @invoice, notice: 'Invoice was successfully created.' }
        format.json { render json: { message: 'Created invoice', invoice: @invoice }, status: :ok }
      else
        format.html { render :new }
        format.json { render json: { message: @invoice.errors }, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { render json: { message: 'Updated invoice', invoice: @invoice }, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: { message: @invoice.errors }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      @invoice.destroy
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { render json: { message: 'Deleted invoice', invoice: nil }, status: :ok }
    end
  end

  private

  def find_invoice
    @invoice = Invoice.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to invoices_path }
      format.json { render json: { message: 'Not found' }, status: :not_found }
    end
  end

  def invoice_params
    params.require(:invoice).permit(:order_id)
  end
end
