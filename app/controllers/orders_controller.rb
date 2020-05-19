class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :mark_complete]
  before_action :authenticate_user!
  before_action :set_listing, only: [:index, :new, :create]

  # GET /orders
  # GET /orders.json

  def index
    if @listing.user.id != current_user.id
      redirect_to listing_path(@listing)
    end
    @orders = Order.where(listing_id: @listing.id)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    render "confirmation"
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new
    @seller = @listing.user
    @order.paid = false
    @order.completed = false
    @order.cost = @listing.price
    @order.listing_id = @listing.id
    @order.seller_id = @seller.id
    @order.buyer_id = current_user.id

    respond_to do |format|
      if @order.save
        format.html { redirect_to listing_path(@listing), notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def mark_complete
    @order.completed = true
    @order.save
    redirect_to sales_dashboard_path
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:listing_id, :cost, :paid, :completed, :buyer, :seller)
  end

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end
end
