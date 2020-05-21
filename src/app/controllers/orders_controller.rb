class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:webhook]
  before_action :set_listing, except: [:webhook]
  skip_before_action :verify_authenticity_token, only: [:webhook]
  before_action :set_user_order, only: [:mark_complete]
  before_action :set_listing_order, only: [:show, :edit, :update, :destroy, :mark_complete]

  # GET /orders
  # GET /orders.json

  def index
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

    # Create a new order
    # Set the properties based on the listing
    # Buyer and seller are defined by listing poster and current user.
    # Order price is defined by the listing price.
    @order = Order.new
    @seller = @listing.user
    @order.paid = false
    @order.completed = false
    @order.cost = @listing.price
    @order.listing_id = @listing.id
    @order.seller_id = @seller.id
    @order.buyer_id = current_user.id
    @order.paid = true
    @order.save

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
    if !@order.paid
      redirect_to sales_dashboard_path, flash: { alert: "You cannot complete an order that has not been paid for."}
    end
    
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

  def webhook

    payment_intent = params["data"]["object"]

    # Create a new order
    # Set the properties based on the listing
    # Buyer and seller are defined by listing poster and current user.
    # Order price is defined by the listing price.
    @order = Order.new
    @order.cost = payment_intent["amount"] / 100
    @order.paid = true
    @order.completed = false
    @order.buyer_id = payment_intent["metadata"]["user_id"]
    @order.seller_id = Listing.find_by_id(payment_intent["metadata"]["listing_id"]).user.id
    @order.listing_id = payment_intent["metadata"]["listing_id"]
    @order.save

  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  def set_user_order
    @order = Order.where(seller_id: current_user.id)
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:listing_id, :cost, :paid, :completed, :buyer, :seller)
  end

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def set_listing_order
    @order = @listing.orders.find_by_id(params[:id])
  end
end
