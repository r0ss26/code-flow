class ListingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :favorite]
  before_action :set_categories, only: [:new, :edit]
  before_action :set_listing, only: [:show]
  before_action :set_user_listing, only: [:edit, :update, :destroy]

  # GET /listings
  # GET /listings.json
  def index
    # Get all of the active listings in the database. Eager load the user to display their information.
    @listings = Listing.where(active:true).paginate(page: params[:page], per_page: 15).includes(:user)
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = current_user.listings.create(listing_params)

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to listings_dashboard_path, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def favorite
    # Get the listing that the user has favorited/unfavorited
    # to toggle the favorite.
    @listing = Listing.find(params[:listing_id])
    if current_user.favorited?(@listing)
      current_user.unfavorite(@listing)
    else
      current_user.favorite(@listing)
    end

    redirect_back fallback_location: listings_path
  end

  private

  def set_listing
    # Get the listing from the url parameter
    @listing = Listing.find(params[:id])
  end

  def set_user_listing
    # See if the current user owns the listing
    @listing = current_user.listings.find_by_id(params[:id])

    if current_user != @listing.user
      redirect_to listing_path(@listing), alert: "Sorry, this listing belongs to someone else"
    end
  end

  def set_categories
    @categories = Category.all
    @category_values = @categories.map{|c| [c.name, c.id]}
  end

  # Only allow a list of trusted parameters through.
  def listing_params
    params.require(:listing).permit(:title, :image, :category_id, :description, :price, :delivery_time, :active, :tag_list)
  end
end

