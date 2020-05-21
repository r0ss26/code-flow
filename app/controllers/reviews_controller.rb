class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:show, :edit, :update]
  before_action :set_listing
  before_action :set_order
  # before_action :set_receiver, only: [:new, :edit, :create,]

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    # Create a new review and set the order_id to that of
    # the order passed into the params. Set the review_poster_id
    # to be the id of the current user and the review_receiver_id
    # to be that of seller of the order.
    @review = @order.create_review(review_params)
    @review.review_poster_id = current_user.id
    @review.review_receiver_id = @order.seller.id
    @review.save

    respond_to do |format|
      if @review.save
        format.html { redirect_to purchases_dashboard_path, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to purchases_dashboard_path, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      # Find the row in the listings table where the id is that
      # of the id passed in to the params.
      @listing = Listing.find(params[:listing_id])
    end

    def set_order
      # Find the row in the orders table where the id is that
      # of the id passed in to the params.
      @order = Order.find(params[:order_id])
    end

    def set_review
      # Find the row in the reviews table where the id is that
      # of the id passed in to the params.
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:rating, :description)
    end
end
