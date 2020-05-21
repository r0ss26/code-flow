class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def purchases
    # Gets all of the orders which the current user is the seller.
    # Eager load the listing and seller child objects for display on the template.
    @purchases = Order.includes(:listing, :seller).where(buyer_id: current_user.id)
    @current_purchases = @purchases.where(completed: false)
    @past_purchases = @purchases.where(completed: true)
  end

  def favorites
    # Get all the listings that the current user has favorited.
    @favorites = current_user.favorited_by_type('Listing')
  end

  def listings
    @listings = Listing.where(user: current_user)
    @active_listings = @listings.where(active: true)
    @inactive_listings = @listings.where(active: false)
  end

  def sales
    # Returns all of the orders which the current user posted that other
    # users have purchased. Eager load the listing and buyer objects.
    @orders = Order.where(seller_id: current_user.id).includes(:listing, :buyer)
    @active_orders = @orders.where(completed: false)
    @past_orders = @orders.where(completed: true)
  end

  def reviews
    # Load any reviews that the current user has received. Eager load the review poster.
    @reviews = Review.where(review_receiver_id: current_user.id).includes(:review_poster)
  end

end