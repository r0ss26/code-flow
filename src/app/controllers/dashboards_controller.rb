class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def purchases
    # Gets all of the orders which the current user is the seller.
    # Eager load the listing and seller child objects for display on the template.

    # This query gets all of the orders from the orders table where the buyer_id 
    # column is equal to the current users id. The listing and seller details
    # are eager loaded because they are accessed in the erb template.
    @purchases = Order.includes(:listing, :seller).where(buyer_id: current_user.id)

    # This query gets all of the orders from the orders which the current user has
    # bought based on whether or not the completed column is true or false.
    @current_purchases = @purchases.where(completed: false)
    @past_purchases = @purchases.where(completed: true)
  end

  def favorites
    # This query gets all of the listings which the current user has favourited.
    @favorites = current_user.favorited_by_type('Listing')
  end

  def listings
    # This query gets all of the listings that current
    # user has created. These are split into active
    # and inactive listings based on the boolean value
    # in the active column.
    @listings = current_user.listings
    @active_listings = @listings.where(active: true)
    @inactive_listings = @listings.where(active: false)
  end

  def sales
    # Returns all of the orders which the current user posted that other
    # users have purchased. Eager load the listing and buyer objects to access
    # them in the erb template.
    @orders = Order.where(seller_id: current_user.id).includes(:listing, :buyer)
    @active_orders = @orders.where(completed: false)
    @past_orders = @orders.where(completed: true)
  end

  def reviews
    # Load any reviews that the current user has received. Eager load the review poster.
    @reviews = Review.where(review_receiver_id: current_user.id).includes(:review_poster)
  end

end